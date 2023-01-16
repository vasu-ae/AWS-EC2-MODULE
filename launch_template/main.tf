resource "aws_launch_template" "my_launch_template" {
  count = var.create_launch_template || var.create_eks_nodegroup_launch_template || var.create_eks_worker_linux_launch_template || var.create_eks_worker_windows_launch_template ? 1 : 0

  name        = var.launch_template_name == null && var.create_eks_nodegroup_launch_template == false && var.create_eks_worker_linux_launch_template == false && var.create_eks_worker_windows_launch_template == false ? local.standard_name : var.launch_template_name == null && var.create_eks_nodegroup_launch_template ? local.node_group_name : var.launch_template_name == null && var.create_eks_worker_linux_launch_template ? local.worker_linux_name : var.launch_template_name == null && var.create_eks_worker_windows_launch_template ? local.worker_windows_name : var.launch_template_name
  ebs_optimized = var.ebs_optimized
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = var.user_data
  vpc_security_group_ids = length(var.network_interfaces) > 0 ? [] : var.security_groups
  update_default_version               = var.update_default_version
  disable_api_termination              = var.disable_api_termination
  disable_api_stop                     = var.disable_api_stop
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  kernel_id                            = var.kernel_id
  ram_disk_id                          = var.ram_disk_id

  monitoring {
    enabled = var.enable_monitoring
  }

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name  = block_device_mappings.value.device_name
     
      dynamic "ebs" {
        for_each = flatten([try(block_device_mappings.value.ebs, [])])
        content {
          delete_on_termination = try(ebs.value.delete_on_termination, null)
          encrypted             = try(ebs.value.encrypted, null)
          kms_key_id            = try(ebs.value.kms_key_id, null)
          iops                  = try(ebs.value.iops, null)
          throughput            = try(ebs.value.throughput, null)
          snapshot_id           = try(ebs.value.snapshot_id, null)
          volume_size           = try(ebs.value.volume_size, null)
          volume_type           = try(ebs.value.volume_type, null)
        }
      }
    }
  }

  dynamic "iam_instance_profile" {
    for_each = var.iam_instance_profile_arn != null ? [1] : []
    content {
      name = var.iam_instance_profile_name
      arn  = var.iam_instance_profile_arn
    }
  }

  dynamic "network_interfaces" {
    for_each = var.network_interfaces
    content {
      # associate_public_ip_address  = try(network_interfaces.value.associate_public_ip_address, null)
      delete_on_termination        = try(network_interfaces.value.delete_on_termination, null)
      device_index                 = try(network_interfaces.value.device_index, null)
      security_groups              = compact(concat(try(network_interfaces.value.security_groups, []), var.security_groups))
      subnet_id                    = try(network_interfaces.value.subnet_id, null)
    }
  }

  tag_specifications {
      resource_type = var.tag_specifications_type
      tags          = merge(
    {
      Name        = var.name
      Environment = var.environment
      Application_ID = var.application_id
    },
    var.default_tags)

    
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [user_data]
  }

}


locals {
  standard_name       = upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"),join("",["LTP",var.server_type]),join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }",var.application_id]) ]))
  node_group_name     = upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"),"EKS","LTPNG", join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }",var.LOB]) ]))
  worker_linux_name   = upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"),"EKS","CLU","LTPLX", join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }",var.LOB]) ]))
  worker_windows_name = upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"),"EKS","CLU","LTPW9", join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }",var.LOB]) ]))

}






