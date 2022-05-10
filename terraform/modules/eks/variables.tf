variable "kube_version" {
  type    = string
  default = "1.21"
}

variable "kube_max_node" {
  type    = number
  default = 4
}

variable "kube_min_node" {
  type    = number
  default = 2
}

variable "kube_instance_types" {
  type    = string
  default = "t3.small"
}

variable "name" {
  type    = string
  default = "lab"
}

variable "name_group" {
  type    = string
  default = "lab-group"
}

variable "subnet_id" {
  type    = list
}

variable "subnet_priv_id" {
  type    = list
}

variable "sg" {
  type    = string
}

