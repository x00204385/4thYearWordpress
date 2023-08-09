resource "aws_lb" "tudproj-LB" {
  name               = "wordpress-LB"
  internal           = false
  load_balancer_type = "application"
  # security_groups    = [aws_security_group.allow-http.id, aws_security_group.allow-https.id]
  security_groups = var.security_group_ids
  # subnets            = [aws_subnet.public-subnet-1a.id, aws_subnet.public-subnet-1b.id]
  subnets = var.lb_subnets


  enable_deletion_protection = false

  tags = {
    Name = "wordpress-LB"
  }
}

resource "aws_lb_listener" "tudproj-Listener" {
  load_balancer_arn = aws_lb.tudproj-LB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress-TG.arn
  }
}


resource "aws_lb_target_group" "wordpress-TG" {
  name     = "wordpress-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = {
    Name = "wordpress-TG"
  }

}

resource "aws_autoscaling_attachment" "wpasg2tg" {
  autoscaling_group_name = aws_autoscaling_group.wpASG.id
  lb_target_group_arn    = aws_lb_target_group.wordpress-TG.arn
}


# Below is replaced with an Autoscaling Group Attachment

# resource "aws_lb_target_group_attachment" "wordpress-attach" {
#   count            = length(aws_instance.wordpressinstance)
#   target_group_arn = aws_lb_target_group.wordpress-TG.arn
#   target_id        = aws_instance.wordpressinstance[count.index].id
#   port             = 80
# }


