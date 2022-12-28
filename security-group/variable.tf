variable "security_group_name" {
  description = "Name of security group"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type = string
  default = null
}

variable "sg_tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {}
}
variable "default_tags" {
  type = any
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
