provider "aws" {
  region = "us-east-1"
}
data "aws_ec2_instance_type_offerings" "supports-my-instance" {
  filter {
    name   = "instance-type"
    values = [var.instance_type] 
  }
  location_type = "availability-zone"
}

data "terraform_remote_state" "subnet_state" {
  backend = "s3"
  config = {
    bucket = var.rm_bucket
    region = var.rm_region
    key    = var.rm_key
  }
}

data "aws_subnet" "az_app_subnets" {
  for_each = toset(split(",", data.terraform_remote_state.subnet_state.outputs.apps_subnets_ids))
  id       = each.key
}

locals {
  azs            = data.aws_ec2_instance_type_offerings.supports-my-instance.locations
  az_app_subnets = flatten([for i in range(length(local.azs)): [for s in data.aws_subnet.az_app_subnets : s.id if s.availability_zone == local.azs[i]]])
}

data "aws_subnet" "app_subnets" {
  for_each = toset(local.az_app_subnets)
  id       = each.key
}

locals {
sorted_values = reverse([for s in sort(formatlist("%d",values(data.aws_subnet.app_subnets)[*].available_ip_address_count)):tonumber(s)])    
app_subnet=distinct(flatten([for i in range(length(local.sorted_values)): [for s in data.aws_subnet.app_subnets : s.id if s.available_ip_address_count == local.sorted_values[i]]]))
}
