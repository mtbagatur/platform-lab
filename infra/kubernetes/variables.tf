variable "namespace" {
  type    = string
  default = "demo"
}

variable "app_name" {
  type    = string
  default = "hello-app"
}

variable "image" {
  type    = string
  default = "hello-app:dev"
}