resource "aws_autoscaling_group" "web_app" {
  name               = "web-asg"
  launch_configuration = var.launch_configuration_id
  vpc_zone_identifier  = var.subnet_ids # Subnets in different AZs

  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity

  load_balancers = [
    {
      target_group_arn = var.target_group_arn
    }
  ]

  # Scaling Policies (Example: CPU Utilization)
  dynamic "scaling_policy" {
    for_each = var.scaling_policies
    content {
      name               = each.key
      adjustment_type   = each.value.adjustment_type
      scaling_adjustment = each.value.scaling_adjustment
      cooldown           = each.value.cooldown
      metric_aggregation_type = each.value.metric_aggregation_type
      target_value         = each.value.target_value
      policy_type        = "TargetTrackingScaling"
    }
  }
}
