/***********************************************************************
// Load balancer variables
/***********************************************************************/
variable "create_loadbalancer" {
  type        = bool
  default     = false
}

variable "server_type" {
  type = string
  default = null
}
variable "lb_name" {
  description = "The resource name of the load balancer."
  type        = string
  default     = null
}

variable "load_balancer_type" {
  description = "The type of load balancer to create. Possible values are application or network."
  type        = string
  default     = ""
}

variable "scheme" {
  description = "Boolean determining if the load balancer is internal or internet-facing. if ture means it will be internal, if false means it will be internet-facing"
  type        = bool
  default     = true
}

variable "lb_security_group" {
  description = "The security groups to attach to the load balancer. e.g. [\"sg-edcd9784\",\"sg-edcd9785\"]"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "A list of subnets to associate with the load balancer.Different availability zones should be required. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f']"
  type        = list(string)
  default     = null
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  type        = number
  default     = 60
}

variable "enable_cross_zone_load_balancing" {
  description = "Indicates whether cross zone load balancing should be enabled in application load balancers."
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
  type        = bool
  default     = false
}

variable "enable_http2" {
  description = "Indicates whether HTTP/2 is enabled in application load balancers."
  type        = bool
  default     = true
}

variable "ip_address_type" {
  description = "The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack."
  type        = string
  default     = "ipv4"
}

variable "drop_invalid_header_fields" {
  description = "Indicates whether invalid header fields are dropped in application load balancers. Defaults to false."
  type        = bool
  default     = false
}

variable "preserve_host_header" {
  description = "Indicates whether Host header should be preserve and forward to targets without any change. Defaults to false."
  type        = bool
  default     = false
}

variable "enable_waf_fail_open" {
  description = "Indicates whether to route requests to targets if lb fails to forward the request to AWS WAF"
  type        = bool
  default     = false
}

variable "desync_mitigation_mode" {
  description = "Determines how the load balancer handles requests that might pose a security risk to an application due to HTTP desync."
  type        = string
  default     = "defensive"
}

variable "access_logs" {
  type = map
  default = {}
} 

variable "load_balancer_create_timeout" {
  description = "Timeout value when creating the ALB."
  type        = string
  default     = "10m"
}

variable "load_balancer_update_timeout" {
  description = "Timeout value when updating the ALB."
  type        = string
  default     = "10m"
}

variable "load_balancer_delete_timeout" {
  description = "Timeout value when deleting the ALB."
  type        = string
  default     = "10m"
}

variable "lb_tags" {
  description = "A map of tags for what you want to add in this load balancer."
  type        = map(string)
  default     = {}
}

variable "add_access_log_bucket_policy" {
  description = "If you wish to add the access log bucket policy, set the value to true."
  type        = bool
  default     = false
}

variable "access_logs_bucket" {
  description = "access log bucket name."
  type        = string
  default     = null
}

variable "default_tags" {
  description = "A map of tags for all"
  type        = map(string)
  default     = {}
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

/***********************************************************************
// Target group variables
/***********************************************************************/
variable "target_groups" {
  description = "A list of maps containing key/value pairs that define the target groups to be created.Required key/values: name, protocol, port"
  type        = any
  default     = []
}

variable "target_group_tags" {
  description = "A map of tags for what you want to add in this target group."
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  default = ""
}

variable "create_target_group" {
  type = bool
  default = false
}

variable "target_group_name" {
  type = string
  default = null
}

variable "standard_name" {
  type = any
  default = []
}


/***********************************************************************
// HTTP listener variables
/***********************************************************************/
variable "create_listener_HTTP" {
  description = "determine the HTTP listener create or not. if true means it will created"
  type = bool
  default = false
}

variable "http_target_group_arn" {
  description = "ARN of the Target Group to which to route traffic. "
  type = list(string)
  default = []
}
variable "http_listener_tags" {
  description = "A map of tags for what you want to add in this listener."
  type        = map(string)
  default     = {}
}
/***********************************************************************
// HTTPS listener variables
/***********************************************************************/
variable "create_listener_HTTPS" {
  description = "determine the HTTPS listener create or not. if true means it will created"
  type = bool
  default = false
}

variable "https_target_group_arn" {
  description = "ARN of the Target Group to which to route traffic. "
  type = list(string)
  default = []
}

variable "https_ssl_policy" {
  description = " Name of the SSL Policy for the listener"
  type = string
  default = "ELBSecurityPolicy-2016-08"
}

variable "acm_certificate_arn" {
  description = "ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS"
  type = string
  default = null
}

variable "https_listener_tags" {
  description = "A map of tags for what you want to add in this listener."
  type        = map(string)
  default     = {}
}

/***********************************************************************
// Target group attachment variables
/***********************************************************************/
variable "create_lb_target_attachment" {
  description = "determine the attachment create or not. if true means the target group and the targets will be attached"
  type = bool
  default = false
}





