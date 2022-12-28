variable "create_autoscaling_group" {
  type = bool
  default = false
}

variable "autosacling_group_name" {
  type = string
  default = null
}

variable "vpc_zone_identifier" {
  type = list(string)
  default = []
}

variable "min_size" {
  type = number
  default = null
}

variable "max_size" {
  type = number
  default = null
}

variable "desired_capacity" {
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

variable "tag" {
  type = any
  default = []
}

