resource "aws_launch_configuration" "web_app" {
  name_prefix   = "web-lc-"
  image_id      = var.ami_id # Use a suitable AMI
  instance_type = var.instance_type

  security_groups = [var.security_group_id]

  user_data = file("${path.module}/user_data.sh") # For application deployment (optional)

  lifecycle {
    create_before_destroy = true
  }
}
