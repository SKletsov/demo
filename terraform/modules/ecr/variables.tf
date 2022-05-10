variable "scan_on_push" {
  default = false 
  type        = bool
}

variable "mutability" {
  default  = "MUTABLE"
  type        = string
}

variable "name" {
  type        = string
}
