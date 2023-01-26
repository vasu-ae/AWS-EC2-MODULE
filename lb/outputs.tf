output "lb_id" {
  description = "The ID and ARN of the load balancer we created"
  value       = try(aws_lb.lb[0].id, "")
}

output "lb_arn" {
  description = "The ID and ARN of the load balancer we created"
  value       = try(aws_lb.lb[0].arn, "")
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = try(aws_lb.lb[0].dns_name, "")
}

output "lb_arn_suffix" {
  description = "ARN suffix of our load balancer - can be used with CloudWatch"
  value       = try(aws_lb.lb[0].arn_suffix, "")
}

output "lb_zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records"
  value       = try(aws_lb.lb[0].zone_id, "")
}

output "http_listener_arns" {
  description = "The ARN of the TCP and HTTP load balancer listeners created"
  value       = aws_lb_listener.http[*].arn
}

output "http_listener_ids" {
  description = "The IDs of the TCP and HTTP load balancer listeners created"
  value       = aws_lb_listener.http[*].id
}

output "https_listener_arns" {
  description = "The ARNs of the HTTPS load balancer listeners created"
  value       = aws_lb_listener.https[*].arn
}

output "https_listener_ids" {
  description = "The IDs of the load balancer listeners created"
  value       = aws_lb_listener.https[*].id
}

output "target_group_arn" {
  description = "ARNs of the target groups. Useful for passing to your Auto Scaling group"
  value       = try(aws_lb_target_group.target_group[*].arn,"")
}

output "target_group_arn_suffixes" {
  description = "ARN suffixes of our target groups - can be used with CloudWatch"
  value       = aws_lb_target_group.target_group[*].arn_suffix
}

output "target_group_names" {
  description = "Name of the target group."
  value       = aws_lb_target_group.target_group[*].name
}

output "targets" {
  description = "ARNs of the target group attachment IDs"
  value       = { for k, v in aws_lb_target_group_attachment.lb_target_attachment : k => v.id }
}

output "arn" {
  description = "ARNs of the target group attachment IDs"
  value       = try(aws_lb_target_group.target_group[*].arn,"")
}

# output "arn" {
#   description = "ARNs of the target group attachment IDs"
#   value       = tolist(try(aws_lb_target_group.target_group[*].arn,""))
# }

