resource "aws_lb" "lb" {
  count = var.create_loadbalancer ? 1 : 0

  name        = var.lb_name == null ? upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"), join("",["ALB" , var.server_type]), join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }",var.application_id]) ])) : var.lb_name
  load_balancer_type = var.load_balancer_type
  internal           = var.scheme
  security_groups    = var.lb_security_group
  subnets            = var.subnets
  idle_timeout                     = var.idle_timeout
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_deletion_protection       = var.enable_deletion_protection
  enable_http2                     = var.enable_http2
  ip_address_type                  = var.ip_address_type
  drop_invalid_header_fields       = var.drop_invalid_header_fields
  preserve_host_header             = var.preserve_host_header
  enable_waf_fail_open             = var.enable_waf_fail_open
  desync_mitigation_mode           = var.desync_mitigation_mode

 dynamic "access_logs" {
    for_each = length(keys(var.access_logs)) == 0 ? [] : [var.access_logs]
  content {
      enabled = try(access_logs.value.enabled, null)
      bucket  = try(access_logs.value.bucket, null)
      prefix  = try(access_logs.value.prefix, null)
    }
  }

  timeouts {
    create = var.load_balancer_create_timeout
    update = var.load_balancer_update_timeout
    delete = var.load_balancer_delete_timeout
  }

  tags = merge(
    {
      "Name"        = var.lb_name == null ? upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"), join("",["ALB" , var.server_type]), join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }",var.application_id]) ])) : var.lb_name
      "Environment" = var.environment
      "Application ID" = var.application_id
    },var.default_tags) 
}


data "aws_elb_service_account" "main" {
count = var.add_access_log_bucket_policy ? 1 : 0
}


resource "aws_s3_bucket_policy" "lb_logs" {
count = var.add_access_log_bucket_policy ? 1 : 0
  bucket = var.access_logs["bucket"]

  policy = <<POLICY
{
  "Id": "Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "s3:PutObject",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.access_logs["bucket"]}/*",
      "Principal": {
        "AWS": [
          "${data.aws_elb_service_account.main[0].arn}"
        ]
      }
    }
  ]
}
POLICY
}

# resource "aws_lb_target_group" "target_group" {
#   count                = var.target_group_name != "" ? 1 : 0 
#   name                 = var.target_group_name 
#   port                 = var.target_group_port
#   protocol             = var.target_group_protocol
#   protocol_version     = var.target_group_protocol_version
#   vpc_id               = var.vpc_id
#   target_type          = var.target_group_target_type
#   deregistration_delay = var.deregistration_delay
#   slow_start           = var.slow_start

#   health_check {
#     protocol            = var.health_check_protocol != null ? var.health_check_protocol : var.target_group_protocol
#     path                = var.health_check_path
#     port                = var.health_check_port
#     timeout             = var.health_check_timeout
#     healthy_threshold   = var.health_check_healthy_threshold
#     unhealthy_threshold = var.health_check_unhealthy_threshold
#     interval            = var.health_check_interval
#     matcher             = var.health_check_matcher
#   }

#   stickiness {
#       type            = "lb_cookie"
#       cookie_duration = var.cookie_duration
#       enabled         = var.enabled
#   }
#   }

#   tags = merge(
#     var.tags,
#     var.default_tags
#   )
# }

# resource "aws_lb" "lb" {
#   count = 1
#   name               = "test-lb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = ["sg-0d7ad396f9e5fe8da"]
#   subnets            = ["subnet-01c2a9858ca3179d3","subnet-04a532a6e01ff95cd"]
  
#    enable_deletion_protection = true

#   tags = {
#     Environment = "production"
#   }
# }

resource "aws_lb_target_group" "target_group" {
count = var.create_target_group ? length(var.target_groups) : 0
  vpc_id               = var.vpc_id
  #name                 = var.target_group_name == null ? upper(join("-",[(var.standard_name[count.index].environment == "DRE" ? "AZO" : "AZV"), join("",["TGP" , var.standard_name[count.index].server_type]), join("",["${upper(var.standard_name[count.index].environment)=="DRE" || upper(var.standard_name[count.index].environment)=="DBG" ? substr(var.standard_name[count.index].environment,1,1) : substr(var.standard_name[count.index].environment,0,1) }",var.standard_name[count.index].application_id]) ])) : var.target_group_name
  name = var.target_group_name == null ? upper(join("-",[(var.target_groups[count.index].environment == "DRE" ? "AZO" : "AZV"), join("",["TGP" , var.target_groups[count.index].server_type]), join("",["${upper(var.target_groups[count.index].environment)=="DRE" || upper(var.target_groups[count.index].environment)=="DBG" ? substr(var.target_groups[count.index].environment,1,1) : substr(var.target_groups[count.index].environment,0,1) }",var.target_groups[count.index].application_id]) ])) : var.target_group_name
  port                 = lookup(var.target_groups[count.index], "port", null)
  protocol             = lookup(var.target_groups[count.index], "protocol", null)
  protocol_version     = lookup(var.target_groups[count.index], "protocol_version", null)
  target_type          = lookup(var.target_groups[count.index], "target_type", null)
  deregistration_delay = lookup(var.target_groups[count.index], "deregistration_delay", null)
  slow_start           = lookup(var.target_groups[count.index], "slow_start", null)

health_check {
      enabled             = lookup(var.target_groups[count.index].health_check, "enabled", null)
      interval            = lookup(var.target_groups[count.index].health_check, "interval", null)
      path                = lookup(var.target_groups[count.index].health_check, "path", null)
      port                = lookup(var.target_groups[count.index].health_check, "port", null)
      healthy_threshold   = lookup(var.target_groups[count.index].health_check, "healthy_threshold", null)
      unhealthy_threshold = lookup(var.target_groups[count.index].health_check, "unhealthy_threshold", null)
      timeout             = lookup(var.target_groups[count.index].health_check, "timeout", null)
      protocol            = lookup(var.target_groups[count.index].health_check, "protocol", null)
      matcher             = lookup(var.target_groups[count.index].health_check, "matcher", null)

  }

  tags = merge(
    {
      "Name"        =  var.target_group_name == null ? upper(join("-",[(var.target_groups[count.index].environment == "DRE" ? "AZO" : "AZV"), join("",["TGP" , var.target_groups[count.index].server_type]), join("",["${upper(var.target_groups[count.index].environment)=="DRE" || upper(var.target_groups[count.index].environment)=="DBG" ? substr(var.target_groups[count.index].environment,1,1) : substr(var.target_groups[count.index].environment,0,1) }",var.target_groups[count.index].application_id]) ])) : var.target_group_name
      "Environment" = var.environment
      "Application ID" = var.application_id
    },var.default_tags) 
}

resource "aws_lb_listener" "http" {
  count             = var.create_listener_HTTP ? 1 : 0
  load_balancer_arn = aws_lb.lb[0].arn
  port              = "80" #var.http_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = var.http_target_group_arn        #aws_lb_target_group.target_group[0].arn
    type             = "forward"

    # tags              = merge(var.http_listener_tags,var.default_tags)

  }
}

resource "aws_lb_listener" "https" {
  count             = var.create_listener_HTTPS ? 1 : 0
  load_balancer_arn = aws_lb.lb[0].arn

  port            = "443" #var.https_port
  protocol        = "HTTPS"
  ssl_policy      = var.https_ssl_policy
  certificate_arn = var.acm_certificate_arn #"arn:aws:acm:us-east-1:237092322265:certificate/f1f52019-acac-48e9-8e1f-393c86be5a7b"  
  # tags            = merge(var.https_listener_tags, var.default_tags)

  default_action {
     target_group_arn = var.https_target_group_arn       #aws_lb_target_group.target_group[0].arn
    type             = "forward"

  }
}

resource "aws_lb_target_group_attachment" "lb_target_attachment" {
for_each = { for k, v in local.target_group_attachments : k => v if var.create_lb_target_attachment == true}
  target_group_arn = aws_lb_target_group.target_group[each.value.tg_index].arn #aws_lb_target_group.target_group[0].arn
  target_id        = each.value.target_id
  port             = lookup(each.value, "port", null)
}


locals {
    target_group_attachments = merge(flatten([
    for index, group in var.target_groups : [
      for k, targets in group : {
        for target_key, target in targets : join(".", [index, target_key]) => merge({ tg_index = index }, target)
      }
      if k == "targets"
    ]
  ] )...)
}

output "name" {
  value = local.target_group_attachments
}


















