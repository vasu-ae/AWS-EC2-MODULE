# AWS EC2 Instance Terraform module

Terraform module which creates an EC2 instance on AWS.
## Usage

#### EC2 Instance with default root volume and customized instance name

```ruby
module "ec2_instance" {
  source  = ""

  create_instance        = true (or) false (Required)
  name                   = "xxxxxxx"
  ami                    = "xxxxxxxxxxxxxx" (Required)
  instance_type          = "xxxxxx" (Required)
  key_name               = "xxxxxx" 
  monitoring             = true (or) false 
  vpc_security_group_ids = ["xxxxxxxx"] 
  subnet_id              = "xxxxxxxxxx"  
  environment            = "xxxxxxx"    (Required)
  application_id         = "xxxxxxxxxx" (Required)
  user_data              = base64encode("xxxxxxx")  
  tenancy                = "xxxxxxxxxx"             
  iam_instance_profile   = "instance profile id" 
  associate_public_ip_address = true (or) false 

}
```

#### EC2 Instance with Customize Root volume and instance name

```ruby
module "ec2_instance" {
  source  = ""


  create_instance        = true (or) false (Required)
  name                   = "xxxxxxx"
  ami                    = "xxxxxxxxxxxxxx" (Required)
  instance_type          = "xxxxxx" (Required)
  key_name               = "xxxxxx" 
  monitoring             = true (or) false 
  vpc_security_group_ids = ["xxxxxxxx"] 
  subnet_id              = "xxxxxxxxxx"  
  environment            = "xxxxxxx"    (Required)
  application_id         = "xxxxxxxxxx" (Required)
  user_data              = base64encode("xxxxxxx")  
  tenancy                = "xxxxxxxxxx"             
  iam_instance_profile   = "instance profile id" 
  associate_public_ip_address = true (or) false 

  root_block_device =[
  {
      delete_on_termination = true (or) false 
      encrypted             = true (or) false 
      iops                  = "100"  
      kms_key_id            = "kms_key_id" 
      volume_size           = "" 
      volume_type           = "" 
      throughput            = "" 
      tags                  = {} 
  }
]
}
```
#### EC2 Instance Customize EBS volume and instance name

```ruby
module "ec2_instance" {
  source  = ""

  create_instance        = true (or) false (Required)
  name                   = "xxxxxxx"
  ami                    = "xxxxxxxxxxxxxx" (Required)
  instance_type          = "xxxxxx" (Required)
  key_name               = "xxxxxx" 
  monitoring             = true (or) false 
  vpc_security_group_ids = ["xxxxxxxx"] 
  subnet_id              = "xxxxxxxxxx"  
  environment            = "xxxxxxx"    (Required)
  application_id         = "xxxxxxxxxx" (Required)
  user_data              = base64encode("xxxxxxx")  
  tenancy                = "xxxxxxxxxx"             
  iam_instance_profile   = "instance profile id" 
  associate_public_ip_address = true (or) false 

  ebs_block_device =[
  {
      device_name           = ""
      delete_on_termination = true (or) false 
      encrypted             = true (or) false 
      iops                  = "100"  
      kms_key_id            = "kms_key_id" 
      volume_size           = "" 
      volume_type           = "" 
      throughput            = "" 
      tags                  = {} 
  }
]

}
```


#### EC2 Instance with Customize Root & EBS volume and instance name

```ruby
module "ec2_instance" {
  source  = ""

  create_instance        = true (or) false (Required)
  name                   = "xxxxxxx" 
  ami                    = "xxxxxxxxxxxxxx" (Required)
  instance_type          = "xxxxxx" (Required)
  key_name               = "xxxxxx" 
  monitoring             = true (or) false 
  vpc_security_group_ids = ["xxxxxxxx"] 
  subnet_id              = "xxxxxxxxxx"  
  environment            = "xxxxxxx"    (Required)
  application_id         = "xxxxxxxxxx" (Required)
  user_data              = base64encode("xxxxxxx")  
  tenancy                = "xxxxxxxxxx"             
  iam_instance_profile   = "instance profile id" 
  associate_public_ip_address = true (or) false 

  root_block_device =[
  {
      delete_on_termination = true (or) false 
      encrypted             = true (or) false 
      iops                  = "100"  
      kms_key_id            = "kms_key_id" 
      volume_size           = "" 
      volume_type           = "" 
      throughput            = "" 
      tags                  = {} 
  }
]

  ebs_block_device =[
  {
      device_name           = ""(Required)
      delete_on_termination = true (or) false 
      encrypted             = true (or) false 
      iops                  = "100"  
      kms_key_id            = "kms_key_id" 
      volume_size           = "" 
      volume_type           = "" 
      throughput            = "" 
      tags                  = {} 
  }
]

}
```


## Resources

| Name | Type |
|------|------|
| [aws_iam_instance.ec2_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

$\mathcal{\color{red}{Inputs}}$
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_instance | Whether to create an instance | `bool` | `null` | **yes** |
| name | Name to be used on EC2 instance created | `string` | `null` | no |
| ami | ID of AMI to use for the instance | `string` | `null` | **yes** |
| instance_type | ID of AMI to use for the instance | `string` | `null` | **yes** |
| key_name | Key name of the Key Pair to use for the instance | `string` | `null` | no |
| monitoring | If true, the launched EC2 instance will have detailed monitoring enabled | `bool` | `fasle` | no |
| vpc_security_group_ids | "A list of security group IDs to associate with" | `list(string)` | `null` | no |
| subnet_id | The VPC Subnet ID to launch in | `string` | `null` | no |
| environment | Environment information | `string` | `null` | **yes** |
| application_id | application id for which application | `string` | `null` | **yes** |
| user_data | User data to provide when launching the instance | `string` | `null` | no |
| tenancy | Tenancy of the instance | `string` | `null` | no |
| iam_instance_profile | IAM Instance Profile to launch the instance with. Specified as the name of the Instance | `string` | `null` | no |
| associate_public_ip_address | Whether to associate a public IP address with an instance in a VPC | `bool` | `null` | no |
| root_block_device | Customize details about the root block device of the instance. See Block Devices below for details | `list(any)` | `[]` | no |
| rootebs_block_device | Additional EBS block devices to attach to the instance | `list(map(string))` | `[]` | no |
| tags | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| default_tags | A map of tags assigned to the resource | `map(string)` | `{}` | no |


