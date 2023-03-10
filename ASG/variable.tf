variable "create_autoscaling_group" {
  type = bool
  default = false
}

variable "autosacling_group_name" {
  type = string
  default = null
}

variable "create_eks_autoscaling_group" {
  type = bool
  default = false
}
variable "instance_name" {
  description = "Name of the instance"
  type        = string
  default     = null
}

variable "server_type" {
  description = "type of the server"
  type        = string
  default     = null 
}

variable "layer" {
  description = "layer of the server"
  type        = string
  default     = null
}

variable "os_version" {
  description = "os version of the server"
  type        = string
  default     = null
}

variable "deploy_method" {
  description = "whether the deployment of the instance is red or black"
  type        = string
  default     = ""
}

variable "vpc_zone_identifier" {
  type = list(string)
  default = []
}

variable "autoscaling_group_min_size" {
  type = number
  default = null
}

variable "autoscaling_group_max_size" {
  type = number
  default = null
}

variable "autoscaling_group_desired_capacity" {
  type = number
  default = null
}

variable "launch_template_id" {
  type = string
  default = null
}

variable "launch_template_version" {
  type = string
  default = null  
}

variable "additional_tag" {
  type = any
  default = []
}

variable "create_autoscaling_group_attachment" {
  type = bool
  default = false
}

variable "aws_autoscaling_group_id" {
  type = string
  default = null
}

variable "aws_lb_target_group_arn" {
  type = list(string)
  default = []
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

variable "autosacling_group_type" {
  type = string
  default = ""
}

variable "LOB" {
  type = string
  default = ""
}


variable "standard_name" {
  type = any
  default = null
}

# locals {
#   standard_name = var.standard_name
# }

variable "create_autoscaling_group_with_targets" {
   type = bool
  default = false 
}

variable "health_check_grace_period" {
  type = string
  default = null 
}

variable "health_check_type" {
  type = string
  default = null  
}

variable "force_delete" {
  type = bool
  default = false
}

variable "target_group_arns" {
  type = list(string)
  default = []
}

variable "suspended_processes" {
  description = "Suspend process for EC2 Server"
  type = list(string)
  default = []
}


