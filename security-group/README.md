# AWS EC2 Instance Terraform module

Terraform module which creates an EC2 instance on AWS.
## Usage

#### aws security group with cidr block value

```ruby
module "security_group" {
  source  = ""

create_security_group = true (or) false (Required)
security_group_name = "" 
vpc_id              = "" (Required)
description         = ""
environment         = ""(Required)
default_tags        = ""
application_id      = ""(Required)
security_group_rules = security_group_rules = [
    {
      protocol                   = "tcp"
      from_port                  = 22
      to_port                    = 22
      type                       = "ingress"

      cidr_blocks                = ["10.0.0.0/16"]
                (OR)
      source_security_group      = true  # if true means same security group will be added as source
                (OR)
      source_security_group_id   = "sg-id"     # other security group will be added as source
      

    },
    {
      protocol                   = "-1"
      from_port                  = 0
      to_port                    = 0
      type                       = "egress"

      cidr_blocks                = ["0.0.0.0/0"]
                (OR)
      source_security_group      = true  # if true means same security group will be added as source
                (OR)
      source_security_group_id   = "sg-id"     # other security group will be added as source
    }

    ]
}

```

## Resources

| Name | Type |
|------|------|
| [aws_security_group.security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

$\mathcal{\color{red}{Inputs}}$

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_security | Whether to create an security group | `bool` | `false` | **yes** |
| security_group_name | Name of the security group | `string` | `null` | `no` |
| vpc_id | ID of the VPC where to create security group | `string` | `null` | **yes** |
| description | Description of the security group | `string` | `null` | `no` |
| environment | Environment information  | `string` | `null` | **yes** |
| application_id | Application information  | `string` | `null` | **yes** |
| default_tags | Environment information  | `string` | `null` | `no` |security_group_rules
| security_group_rules | if you need to create one (or) multiple security group rules, use this argument. The given input shoud be list of map value ie. {key = values} | `any` | `[]` | `no` |
