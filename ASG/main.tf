resource "aws_autoscaling_group" "my_asg" {
  count = var.create_autoscaling_group ? 1 : 0

name = var.autosacling_group_name == null ? lower(join("-" , [ join("",[(var.environment == "DRE" ? "AZO" : "AZV"), "AUS", var.server_type, upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1)]) , join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }","${var.application_id}"]) ])) : var.eks_autoscaling_group_creation ? upper(join("-" , [ join("",[(var.environment == "DRE" ? "AZO" : "AZV"),"EKS","CLU", join("",["AUS", var.server_type]), upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1)]) , join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }","${var.application_id}"]) ])) : var.autosacling_group_name

 vpc_zone_identifier       = var.vpc_zone_identifier
 min_size                  = var.min_size
 max_size                  = var.max_size
 desired_capacity          = var.desired_capacity


  launch_template {
      id      = var.launch_template_id
      version = var.launch_template_version
  }

  dynamic "tag" {
    for_each = var.tag != [] ? var.tag : []
    content {
      key = tag.value.key
      value = tag.value.value
      propagate_at_launch = tag.value.propagate_at_launch
    }
  }

  lifecycle {
    create_before_destroy = true

  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  count = var.create_autoscaling_group_attachment ? length(var.aws_lb_target_group_arn) : 0
  autoscaling_group_name = var.aws_autoscaling_group_id
  lb_target_group_arn    = element(var.aws_lb_target_group_arn,count.index)
}





