data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default2" {
  vpc_id = data.aws_vpc.default.id
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "my-alb"

  load_balancer_type = "application"

  vpc_id = data.aws_vpc.default.id
  subnets = data.aws_subnet_ids.default2.ids

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTPS"
      backend_port     = 443
      target_type      = "instance"
      targets = [
        {
          target_id = aws_instance.grafana01.id
          port = 3000
        },
        {
          target_id = aws_instance.grafana02.id
          port = 3000
        }
      ]
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "arn:aws:acm:us-east-1:158156967464:certificate/3a4328f2-c618-4ec6-b4c3-ee93726e07b0"
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      action_type        = "redirect"
      redirect = {
        port	= "443"
	protocol	= "HTTPS"
	status_code	= "HTTP_301"
      }
    }
  ]

  tags = {
    Environment = "Test"
  }
}
