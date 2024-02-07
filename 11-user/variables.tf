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
    Component = "user"
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

variable "iam_instance_profile" {
  default = "roboshopapp-role"
}
