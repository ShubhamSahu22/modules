module "security_group" {
  vpc_id = var.vpc_id
  prefix = "web"
}

module "launch_configuration" {
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  security_group_id  = module.security_group.web_server_id
}

module "alb" {
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  alb_security_group_id = module.security_group.alb_sg_id # Create a separate SG for the ALB
}

module "autoscaling" {
  launch_configuration_id = module.launch_configuration.id
  vpc_zone_identifier = var.subnet_ids
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
  target_group_arn = module.alb.target_group_arn
  scaling_policies = {
    cpu_high = {
      adjustment_type = "ChangeInTargetCapacity"
      scaling_adjustment = 1 # Add 1 instance
      cooldown = 300
      metric_aggregation_type = "Average"
      target_value = 70 # Target CPU utilization
    }
  }
}
