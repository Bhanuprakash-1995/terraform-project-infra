resource "aws_lb" "app_alb" {
  name               = "${local.name}-${var.tags.Component}" #roboshop-dev-app-alb
  internal           = true
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.app_alb_sg_id.value]
  subnets            = split(",", data.aws_ssm_parameter.private_subnet_ids.value)

  #enable_deletion_protection = true

  tags = merge(
    var.common_tags,
    var.tags
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Hi, This response is from APP ALB"
      status_code  = "200"
    }
  }
}

#.app-dev.daws86s.online
module "records" {
  source    = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_name #daws86s.online
  records = [
    {
      name = "*.app-${var.environment}" #catalogue.app-dev.daws86s.online
      type = "A"
      alias = {
        name    = aws_lb.app_alb.dns_name
        zone_id = aws_lb.app_alb.zone_id
      }
    }
  ]
}
