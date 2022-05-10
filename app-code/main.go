package main

import (
	"encoding/json"
	"fmt"
	"github.com/gin-gonic/gin"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

type error interface {
	Error() string
}

type data struct {
	Id          int    `json:"id"`
	Main        string `json:"main"`
	Description string `json:"description"`
	Icon        string `json:"icon"`
}

type response struct {
	Weather []data `json:"weather"`
}

var (
	err error
)

type Data struct {
	ApiKey string `json:"api_key"`
}

func ping(c *gin.Context) {
	var apiData Data
	c.Bind(&apiData)
	myHtmlString := "<html><body>PONG</body></html>"
	c.Writer.WriteHeader(http.StatusOK)
	c.Writer.Write([]byte(myHtmlString))
	return
}

func health(c *gin.Context) {
	var apiData Data
	c.Bind(&apiData)
	c.JSON(
		http.StatusOK,
		gin.H{
			"status": "200",
		},
	)

}

func getRequestAPI() (string, bool) {
	apiKey := os.Getenv("API_KEY")
	url := "https://api.openweathermap.org/data/2.5/weather?lat=45.071096&lon=-69.891586&appid=" + apiKey + ""
	method := "GET"
	client := &http.Client{}
	req, err := http.NewRequest(method, url, nil)

	if err != nil {
		fmt.Println(err)
		return "", false
	}
	res, err := client.Do(req)
	if err != nil {
		fmt.Println(err)
		return "", false
	}
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		fmt.Println(err)
		return "", false
	}
	//fmt.Println(string(body))
	var api response
	err = json.Unmarshal(body, &api)
	if err != nil {
		log.Println("JSON ERR")
	}
	return api.Weather[0].Main, true
}
func sample(c *gin.Context) {
	data, _ := getRequestAPI()
	c.JSON(
		http.StatusOK,
		gin.H{
			"weather": data,
		},
	)
	return
}

func main() {
	r := gin.Default()
	r.Use(gin.Logger())
	r.Use(gin.Recovery())
	v1 := r.Group("/")
	{
		v1.GET("", sample)
		v1.GET("ping", ping)
		v1.GET("health", health)
	}
	r.Run(":8080")
}
