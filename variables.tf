variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources in"
  default     = "us-east-1" # Change to your preferred region
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to use for EC2 instances"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro" # Or t3.micro, or other suitable type
}

variable "min_size" {
  type        = number
  description = "Minimum number of EC2 instances in the ASG"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Maximum number of EC2 instances in the ASG"
  default     = 3
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of EC2 instances in the ASG"
  default     = 1
}

variable "app_zip_path" {
  type        = string
  description = "Path to the application zip file"
}

variable "app_port" {
  type = number
  description = "Port your application listens on"
  default = 3000
}

variable "alb_security_group_id" {
  type = string
  description = "Security group ID for the ALB"
}

variable "web_server_security_group_id" {
  type = string
  description = "Security group ID for the web servers"
}

variable "scaling_policies" {
  type = map(object({
    adjustment_type   = string
    scaling_adjustment = number
    cooldown           = number
    metric_aggregation_type = string
    target_value         = number
  }))
  description = "Map of scaling policies"
  default = {
    cpu_high = {
      adjustment_type = "ChangeInTargetCapacity"
      scaling_adjustment = 1
      cooldown = 300
      metric_aggregation_type = "Average"
      target_value = 70
    }
  }
}
