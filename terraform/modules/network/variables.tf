variable "vpc_cid" {
  type    = string
  default = "10.0.0.0/16"
}

variable "cid_pub" {
  type    = string
  default = "10.0.40.0/24"
}

variable "cid_priv" {
  type    = string
  default = "10.0.20.0/24"
}

variable "name" {
  type    = string
  default = "sample"
}
