resource "aws_security_group" "security_group" {
    count = local.control && var.create_security_group || var.create_eks_cluster_security_group || var.create_eks_worker_security_group ? 1 : 0
  #name = var.security_group_name #Required
  name =  var.security_group_name == null && var.create_eks_cluster_security_group == false && var.create_eks_worker_security_group == false ? upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"), join("",["SG",var.server_type]), join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }","${var.application_id}"]) ])) : var.security_group_name == null && var.create_eks_cluster_security_group ? upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"),"EKS",join("",["CLU","SG"]),join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }",var.LOB]) ])) : var.security_group_name == null && var.create_eks_worker_security_group ? upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"),"EKS",join("",["SG" ,var.server_type ]),join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }",var.LOB]) ])) :  var.security_group_name
  description = var.description #optional
  vpc_id      = var.vpc_id #Required
  tags = merge(
    {
      "Name"        = var.security_group_name == null && var.create_eks_cluster_security_group == false && var.create_eks_worker_security_group == false ? upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"), join("",["SG",var.server_type]), join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }","${var.application_id}"]) ])) : var.security_group_name == null && var.create_eks_cluster_security_group ? upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"),"EKS",join("",["CLU","SG"]),join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }",var.LOB]) ])) : var.security_group_name == null && var.create_eks_worker_security_group ? upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"),"EKS",join("",["SG" ,var.server_type ]),join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }",var.LOB]) ])) :  var.security_group_name
      "Environment" = var.environment
      "Application ID" = var.application_id
    },var.default_tags) 
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

locals {
  control = var.application_id == null && var.environment == null ? false : true
}
