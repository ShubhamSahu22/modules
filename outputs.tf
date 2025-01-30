output "alb_dns_name" {
  value       = module.alb.alb_dns_name
  description = "DNS name of the Application Load Balancer"
}

output "autoscaling_group_name" {
  value = module.autoscaling.autoscaling_group_name
  description = "Name of the Auto Scaling Group"
}
