variable "create_security_group" {
  type = bool
  description = "Whether to create an instance"
  default = false
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type = string
  default = null
}


variable "default_tags" {
  type = map
  default = {}
}

variable "environment" {
  description = "tag for which environment"
  type = string
  default = null
}

variable "application_id" {
  description = "application id for recuirement application"
  type = string
  default = null 
}

variable "security_group_rules" {
  description = "List of security group rules"
  type        = any
  default     = []
}

variable "description" {
  type = string
  default = null
}

variable "create_eks_cluster_security_group" {
  type = bool
  default = false
}

variable "create_eks_worker_security_group" {
  type = bool
  default = false 
}

variable "server_type" {
  type = string
  default = "WEB"
}

variable "LOB" {
  type = string
  default = null
}
