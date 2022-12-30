variable "create_instance" {
  type = bool
  description = "Whether to create an instance"
  default = null
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = null
}

variable "name" {
  description = "Name of the instance"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = null
}

variable "instance_profile" {
  description = "IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile"
  type        = string
  default     = null
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with an instance in a VPC"
  type        = bool
  default     = null
}

variable "ssh_key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}

variable "subnet" {
  description = "The VPC Subnet ID to launch in"
  type = string
  default = null
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type = bool
  default = false
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  type        = string
  default     = null
}

variable "security_groups" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance"
  type        = list(any)
  default     = []
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(map(string))
  default     = []
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


