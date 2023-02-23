variable "instance_type" {
  description = "instance type detail"
  type = string
  default = null
}

variable "rm_bucket" {
  description = "bucket name"
  type = string
  default = null
}

variable "rm_region" {
  description = "region name"
  type = string
  default = null
}

variable "rm_key" {
  description = "key path"
  type = string
  default = null
}
