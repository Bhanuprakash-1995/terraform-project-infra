locals {
  name         = "${var.project_name}-${var.environment}" #roboshop-dev
  current_time = formatdate("YYYY-MM-DD-hh-mm", timestamp())
}
