
output "autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = try(aws_autoscaling_group.my_asg[0].id, "")
}

output "autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = try(aws_autoscaling_group.my_asg[0].name, "")
}

output "autoscaling_group_arn" {
  description = "The ARN for my_asg AutoScaling Group"
  value       = try(aws_autoscaling_group.my_asg[0].arn, "")
}

output "autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = try(aws_autoscaling_group.my_asg[0].min_size, "")
}

output "autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = try(aws_autoscaling_group.my_asg[0].max_size, "")
}

output "autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = try(aws_autoscaling_group.my_asg[0].desired_capacity, "")
}

output "autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = try(aws_autoscaling_group.my_asg[0].default_cooldown, "")
}

output "autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = try(aws_autoscaling_group.my_asg[0].health_check_grace_period, "")
}

output "autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = try(aws_autoscaling_group.my_asg[0].health_check_type, "")
}

output "autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = try(aws_autoscaling_group.my_asg[0].availability_zones, [])
}

output "autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = try(aws_autoscaling_group.my_asg[0].vpc_zone_identifier, [])
}

output "autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = try(aws_autoscaling_group.my_asg[0].load_balancers, [])
}

output "autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to my_asg AutoScaling Group"
  value       = try(aws_autoscaling_group.my_asg[0].target_group_arns, [])
}

output "autoscaling_group_enabled_metrics" {
  description = "List of metrics enabled for collection"
  value       = try(aws_autoscaling_group.my_asg[0].enabled_metrics, [])
}

output "auto_scaling_group_attachment" {
  value = aws_autoscaling_attachment.asg_attachment
}