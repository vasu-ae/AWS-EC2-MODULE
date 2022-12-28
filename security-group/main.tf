resource "aws_security_group" "security_group" {
    count = var.security_group_name != "" ? 1 : 0
  name_prefix = var.security_group_name #Required
  description = var.description #optional
  vpc_id      = var.vpc_id #Required
  tags            = try(merge(var.sg_tags, var.default_tags),null) #optional
}

resource "aws_security_group_rule" "security_group_rules" {
  count = length(var.security_group_rules)# Required
  
  security_group_id = aws_security_group.security_group[0].id
  protocol          = var.security_group_rules[count.index].protocol
  from_port         = var.security_group_rules[count.index].from_port
  to_port           = var.security_group_rules[count.index].to_port
  type              = var.security_group_rules[count.index].type
  description      = try(var.security_group_rules[count.index].description, null)

  cidr_blocks      = try(var.security_group_rules[count.index].cidr_blocks, null) #either use cidr block or source security group id
                    #OR
  source_security_group_id =  try(var.security_group_rules[count.index].source_security_group_id,try(var.security_group_rules[count.index].source_security_group, false) ? aws_security_group.security_group[0].id : null)
}

