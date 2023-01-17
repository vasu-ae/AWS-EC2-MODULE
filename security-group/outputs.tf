output "security_group_id" {
  value = try(aws_security_group.security_group[0].id,"")
}

output "security_group_arn" {
  value = try(aws_security_group.security_group[0].arn,"")
}