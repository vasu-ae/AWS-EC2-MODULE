## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_attachment.asg_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment) | resource |
| [aws_autoscaling_group.asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_group.autoscaling_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_LOB"></a> [LOB](#input\_LOB) | n/a | `string` | `""` | no |
| <a name="input_additional_tag"></a> [additional\_tag](#input\_additional\_tag) | n/a | `any` | `[]` | no |
| <a name="input_application_id"></a> [application\_id](#input\_application\_id) | application id for recuirement application | `string` | `null` | no |
| <a name="input_autosacling_group_name"></a> [autosacling\_group\_name](#input\_autosacling\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_autosacling_group_node_type"></a> [autosacling\_group\_node\_type](#input\_autosacling\_group\_node\_type) | n/a | `string` | `""` | no |
| <a name="input_autosacling_group_type"></a> [autosacling\_group\_type](#input\_autosacling\_group\_type) | n/a | `string` | `""` | no |
| <a name="input_autoscaling_group_desired_capacity"></a> [autoscaling\_group\_desired\_capacity](#input\_autoscaling\_group\_desired\_capacity) | n/a | `number` | `null` | no |
| <a name="input_autoscaling_group_max_size"></a> [autoscaling\_group\_max\_size](#input\_autoscaling\_group\_max\_size) | n/a | `number` | `null` | no |
| <a name="input_autoscaling_group_min_size"></a> [autoscaling\_group\_min\_size](#input\_autoscaling\_group\_min\_size) | n/a | `number` | `null` | no |
| <a name="input_aws_autoscaling_group_id"></a> [aws\_autoscaling\_group\_id](#input\_aws\_autoscaling\_group\_id) | n/a | `string` | `null` | no |
| <a name="input_aws_lb_target_group_arn"></a> [aws\_lb\_target\_group\_arn](#input\_aws\_lb\_target\_group\_arn) | n/a | `list(string)` | `[]` | no |
| <a name="input_create_autoscaling_group"></a> [create\_autoscaling\_group](#input\_create\_autoscaling\_group) | n/a | `bool` | `false` | no |
| <a name="input_create_autoscaling_group_attachment"></a> [create\_autoscaling\_group\_attachment](#input\_create\_autoscaling\_group\_attachment) | n/a | `bool` | `false` | no |
| <a name="input_create_autoscaling_group_with_targets"></a> [create\_autoscaling\_group\_with\_targets](#input\_create\_autoscaling\_group\_with\_targets) | n/a | `bool` | `false` | no |
| <a name="input_create_eks_autoscaling_group"></a> [create\_eks\_autoscaling\_group](#input\_create\_eks\_autoscaling\_group) | n/a | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | tag for which environment | `string` | `null` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | n/a | `bool` | `false` | no |
| <a name="input_health_check_grace_period"></a> [health\_check\_grace\_period](#input\_health\_check\_grace\_period) | n/a | `string` | `null` | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | n/a | `string` | `null` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name of the instance | `string` | `null` | no |
| <a name="input_launch_template_id"></a> [launch\_template\_id](#input\_launch\_template\_id) | n/a | `string` | `null` | no |
| <a name="input_launch_template_version"></a> [launch\_template\_version](#input\_launch\_template\_version) | n/a | `string` | `null` | no |
| <a name="input_standard_name"></a> [standard\_name](#input\_standard\_name) | Name of the instance as per devops pillar standards. | `map` | `{}` | no |
| <a name="input_suspended_processes"></a> [suspended\_processes](#input\_suspended\_processes) | Suspend process for EC2 Server | `list(string)` | `[]` | no |
| <a name="input_target_group_arns"></a> [target\_group\_arns](#input\_target\_group\_arns) | n/a | `list(string)` | `[]` | no |
| <a name="input_vasu"></a> [vasu](#input\_vasu) | n/a | `string` | `""` | no |
| <a name="input_vpc_zone_identifier"></a> [vpc\_zone\_identifier](#input\_vpc\_zone\_identifier) | n/a | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN for asg AutoScaling Group |
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_default_cooldown"></a> [default\_cooldown](#output\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_desired_capacity"></a> [desired\_capacity](#output\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_enabled_metrics"></a> [enabled\_metrics](#output\_enabled\_metrics) | List of metrics enabled for collection |
| <a name="output_health_check_grace_period"></a> [health\_check\_grace\_period](#output\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_health_check_type"></a> [health\_check\_type](#output\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_id"></a> [id](#output\_id) | The autoscaling group id |
| <a name="output_load_balancers"></a> [load\_balancers](#output\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_max_size"></a> [max\_size](#output\_max\_size) | The maximum size of the autoscale group |
| <a name="output_min_size"></a> [min\_size](#output\_min\_size) | The minimum size of the autoscale group |
| <a name="output_name"></a> [name](#output\_name) | The autoscaling group name |
| <a name="output_target_group_arns"></a> [target\_group\_arns](#output\_target\_group\_arns) | List of Target Group ARNs that apply to asg AutoScaling Group |
| <a name="output_vpc_zone_identifier"></a> [vpc\_zone\_identifier](#output\_vpc\_zone\_identifier) | The VPC zone identifier |
