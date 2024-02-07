variable "project_name" {
  type    = string
  default = "roboshop"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "tags" {
  default = {
    Component = "web-alb"
  }
}
variable "common_tags" {
  default = {
    Project     = "roboshop"
    Enviornment = "dev"
    Terraform   = "true"
  }
}

variable "zone_name" {
  default = "daws86s.online"
}
