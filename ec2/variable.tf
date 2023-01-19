/***************************************************
// EC2 INSTANCE VARIABLES
***************************************************/
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

variable "volume_tags" {
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


/****************************************************************
//EBS VOLUME VARIABLES
***************************************************************/

variable "create_ebs_volume" {
  description = "Whether to create an ebs volume"
  type = bool
  default = false
}
variable "ebs_volume_name" {
  description = "Name of the ebs volume"
  type = string
  default = null  
}

variable "encrypted" {
  description = "If true, the disk will be encrypted."
  type = bool
  default = null
}

variable "iops" {
  default = null
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. When specifying kms_key_id, encrypted needs to be set to true"
  type = string
  default = null
}

variable "snapshot_id" {
  description = "A snapshot to base the EBS volume off of."
  type = string
  default = null
}

variable "volume_size" {
  description = "The size of the drive in GiBs."
  type = string
  default = null
}

variable "volume_type" {
  description = "The type of EBS volume. Can be standard, gp2, gp3, io1, io2, sc1 or st1 (Default: gp2)."
  type = string
  default = null
}

variable "throughput" {
  description = "The throughput that the volume supports, in MiB/s. Only valid for type of gp3."
  type = string
  default = null
}

variable "additional_ebs_tags" {
  description = "A map of tags to assign to the ebs volume"
  type = map(string)
  default = null
}

/***************************************************************
// EBS VOLUME ATTACHMENT VARIABLES
**************************************************************/

variable "create_ebs_volume_attachment" {
  description = "Whether to create an ebs volume attachment"
  type = bool
  default = false
}

# variable "ebs_volume_name" {
#   description = "Name of the EBS volume"
#   type = string
#   default = null
# }

variable "ebs_volume_id" {
  description = "ID of the Volume to be attached instance"
  type = string
  default = null
}

variable "instance_id" {
  description = "ID of the Instance"
  type = string
  default = null
}

variable "standard_name" {
  type = map
  default = {}
}


