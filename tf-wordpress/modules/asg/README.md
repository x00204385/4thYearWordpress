## AWS AutoScaling Group
Create an autoscaling group running EC2 instances and execute an installation script to install software. Create a load balancer to 
distribute traffic across the instances. Create CloudWatch alarms to trigger autoscaling events.

<!-- BEGIN_TF_DOCS -->
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
| [aws_autoscaling_attachment.wpasg2tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment) | resource |
| [aws_autoscaling_group.wpASG](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.scale_down](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_policy.scale_up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_cloudwatch_metric_alarm.cw_scale_down](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cw_scale_up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_launch_configuration.wordpress-LC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_lb.tudproj-LB](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.tudproj-Listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.wordpress-TG](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_subnets"></a> [asg\_subnets](#input\_asg\_subnets) | Subnet ids into used for the autoscaling group | `list(string)` | `null` | no |
| <a name="input_instance-ami"></a> [instance-ami](#input\_instance-ami) | The AMI used to create the instances | `string` | `"ami-0cc4e06e6e710cd94"` | no |
| <a name="input_key-pair"></a> [key-pair](#input\_key-pair) | The public/private keypair used to access the EC2 instances created | `string` | `"tud-aws"` | no |
| <a name="input_lb_subnets"></a> [lb\_subnets](#input\_lb\_subnets) | Subnet ids into used by the load balancerr | `list(string)` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The region in which the EKS cluster is created | `string` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | The security groups to apply to the autoscaling group instances | `list` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where to infrastructure will be created | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_endpoint"></a> [lb\_endpoint](#output\_lb\_endpoint) | The DNS address of the load balancer that is created |
<!-- END_TF_DOCS -->