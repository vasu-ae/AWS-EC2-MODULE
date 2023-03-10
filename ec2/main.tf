/*********************************************************
//EC2 INSTANCE RESOURCE BLOCK
**********************************************************/

resource "aws_instance" "ec2_instance" {
  count = var.create_instance ? 1 : 0
  ami                                  = var.ami #required
  instance_type                        = var.instance_type 
  user_data                            = var.user_data
  iam_instance_profile                 = var.instance_profile
  associate_public_ip_address          = var.associate_public_ip_address
  key_name                             = var.ssh_key_name
  subnet_id                            = var.subnet
  monitoring                           = var.monitoring
  tenancy                              = var.tenancy
  vpc_security_group_ids               = var.security_groups

  
  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      throughput            = lookup(root_block_device.value, "throughput", null)
      # tags                  = lookup(root_block_device.value, "tags", null)
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = lookup(ebs_block_device.value, "device_name", null)
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      throughput            = lookup(ebs_block_device.value, "throughput", null)
    }
  }

  tags = merge(
    {
     "Name"        = var.instance_name == null ? upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"), join("",[upper(var.standard_name["server_type"]) == "WEB" ? "WS" : "AS" ,substr(var.standard_name["layer"],0,1),var.standard_name["os_version"]]), join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }","${var.application_id}",var.standard_name["deploy_method"] != "" ? substr(var.standard_name["deploy_method"],0,1): ""]) ])) : var.instance_name
      "Environment" = var.environment
      "Application ID" = var.application_id
    },var.default_tags)

  volume_tags = merge(
    {
     "Name"        = upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"), upper(var.standard_name["server_type"]),join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }","${var.application_id}"]) ]))
      "Environment" = var.environment
      "Application ID" = var.application_id
    },var.default_tags)  


}



/*********************************************************
//EBS VOLUME RESOURCE BLOCK
**********************************************************/

resource "aws_ebs_volume" "ebs_volume" {
  count = var.create_ebs_volume ? 1 : 0

  availability_zone = "us-east-1a"

  encrypted             = try(var.encrypted, null)
  iops                  = try(var.iops, null)
  kms_key_id            = try(var.kms_key_id, null)
  snapshot_id           = try(var.snapshot_id, null)
  size                  = try(var.volume_size, null)
  type                  = try(var.volume_type, null)
  throughput            = try(var.throughput, null)
  #ebs_tags              = try(var.tags, null)
  tags = merge(
    {
      "Name"        = var.ebs_volume_name == null ? upper(join("-",[(var.environment == "DRE" ? "AZO" : "AZV"), join("",[var.server_type ,substr(var.layer,0,1),var.os_version]), join("",["${upper(var.environment)=="DRE" || upper(var.environment)=="DBG" ? substr(var.environment,1,1) : substr(var.environment,0,1) }","${var.application_id}",var.deploy_method != "" ? substr(var.deploy_method,0,1): ""]) ])) : var.instance_name
      "Environment" = var.environment
      "Application ID" = var.application_id
    },var.additional_ebs_tags)


  # lifecycle {
  #   prevent_destroy = true
  # }
}



/*********************************************************
//EBS VOLUME ATTACHMENT RESOURCE BLOCK
**********************************************************/

resource "aws_volume_attachment" "ebs_attachment" {
  count = var.create_ebs_volume_attachment ? 1 : 0
  device_name = var.ebs_volume_name
  volume_id   = var.ebs_volume_id
  instance_id = var.instance_id
}