resource "aws_autoscaling_group" "my_asg" {
  count = var.create_autoscaling_group || var.eks_autoscaling_group_creation ? 1 : 0
name = var.autosacling_group_name == null && var.eks_autoscaling_group_creation == false ? lower(join("-" , [ join("-",[(var.environment == "DRE" ? "AZO" : "AZV"), join("",["AUS", var.server_type])]) , join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }","${var.application_id}",var.deploy_method != "" ? substr(var.deploy_method,0,1): ""]) ])) : var.autosacling_group_name == null && var.eks_autoscaling_group_creation ? upper(join("-" , [ join("-",[(var.environment == "DRE" ? "AZO" : "AZV"),"EKS","CLU", join("",["AUS", var.server_type])]) , join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }","${var.application_id}"]) ])) : var.autosacling_group_name
 vpc_zone_identifier       = var.vpc_zone_identifier
 min_size                  = var.autoscaling_group_min_size
 max_size                  = var.autoscaling_group_max_size
 desired_capacity          = var.autoscaling_group_desired_capacity


  launch_template {
      id      = var.launch_template_id
      version = var.launch_template_version != null ? var.launch_template_version : "$Latest"
  }

  tag {
      key =  "Application ID" 
      value =  var.application_id
      propagate_at_launch  = true
  }

  tag {
      key =  "Environment"
      value =  var.environment
      propagate_at_launch  = true
  }

    tag {
      key =  "Name"
      value =  var.instance_name == null ? upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"), join("",[var.server_type ,substr(var.layer,0,1),var.os_version]), join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }","${var.application_id}",var.deploy_method != "" ? substr(var.deploy_method,0,1): ""]) ])) : var.instance_name
      propagate_at_launch  = true
  }

  dynamic "tag" {
    for_each = var.additional_tag != [] ? var.additional_tag : []
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





