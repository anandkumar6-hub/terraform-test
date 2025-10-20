resource "aws_key_pair" "deployer" {
  key_name   = "${var.project_name}-key"
  public_key = file("~/.ssh/id_rsa.pub")  # path to your local public key
}

resource "aws_instance" "app" {
  for_each = toset(var.private_subnet_ids)

  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = each.key
  key_name               = aws_key_pair.deployer.key_name
  iam_instance_profile   = var.iam_instance_profile_name
  vpc_security_group_ids = [var.db_sg_id]

  tags = merge(
    var.tags,
    { Name = "${var.project_name}-app-${each.key}" }
  )
}

resource "aws_lb" "app_alb" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [var.web_sg_id]

  tags = merge(
    var.tags,
    { Name = "${var.project_name}-alb" }
  )
}
 
resource "aws_lb_target_group" "app_tg" {
  name     = "${var.project_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = element(var.private_subnet_ids, 0)  # pick first private subnet for VPC reference

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
  }

  tags = merge(
    var.tags,
    { Name = "${var.project_name}-tg" }
  )
}

resource "aws_lb_target_group_attachment" "app_attach" {
  for_each = aws_instance.app

  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = each.value.id
  port             = 80
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
