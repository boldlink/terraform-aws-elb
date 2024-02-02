[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-elb/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-elb.svg)](https://github.com/boldlink/terraform-aws-elb/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-elb/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-elb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-elb/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-elb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-elb/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-elb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-elb/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-elb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-elb/actions/workflows/module-examples-tests.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-elb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-elb/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-elb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-elb/actions/workflows/auto-merge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-elb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-elb/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-elb/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# AWS Elastic Load Balancer Terraform module

## Description

This terraform module creates an Elastic Load Balancer (Commonly known as Classic Load Balancer) and Access logs bucket if specified

## Advantages of the Module

### 1. Simplified Access Logs Management
- This module streamlines the creation of an Elastic Load Balancer (commonly known as Classic Load Balancer) and automatically sets up an S3 bucket for access logs. When you specify `create_access_logs_bucket = true`, the module takes care of the access logs configuration, saving you time and effort.

### 2. Enhanced Security
- Security is a top priority, and this module adheres to AWS security best practices. It enforces compliance using Checkov, ensuring that your Elastic Load Balancer is configured securely.

### 3. Streamlined Operations
- With this module, you can create and manage Elastic Load Balancers efficiently, reducing the complexity of your infrastructure provisioning process. It provides a structured and easy-to-use interface for managing load balancers.

### 4. Well-Maintained and Documented
- This module is actively maintained and regularly updated to align with the latest AWS and Terraform best practices. Detailed documentation is available to assist you in using and customizing the module to meet your specific requirements.

Examples available [here](./examples)

## Usage
**NOTE**: These examples use the latest version of this module

```hcl
module "elb" {
  source             = "boldlink/elb/aws"
  version            = "<latest_module_version>"
  name               = "minimal-example-elb"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [data.aws_security_group.default.id]
  availability_zones = data.aws_availability_zones.available.names

  # Listeners
  listeners = [
    {
      instance_port     = 8080
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    }
  ]
}
```

## Documentation

[AWS Elastic Load Balancer documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/introduction.html)

[Terraform provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elb)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.15.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.34.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elb) | resource |
| [aws_load_balancer_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/load_balancer_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs"></a> [access\_logs](#input\_access\_logs) | (Optional) An Access Logs block. | `map(string)` | `{}` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | (Required for an EC2-classic ELB) The AZ's to serve traffic in. | `list(string)` | `[]` | no |
| <a name="input_connection_draining"></a> [connection\_draining](#input\_connection\_draining) | (Optional) Boolean to enable connection draining. Default: `false` | `bool` | `false` | no |
| <a name="input_connection_draining_timeout"></a> [connection\_draining\_timeout](#input\_connection\_draining\_timeout) | (Optional) The time in seconds to allow for connections to drain. Default: `300` | `number` | `300` | no |
| <a name="input_cross_zone_load_balancing"></a> [cross\_zone\_load\_balancing](#input\_cross\_zone\_load\_balancing) | (Optional) Enable cross-zone load balancing. | `bool` | `true` | no |
| <a name="input_desync_mitigation_mode"></a> [desync\_mitigation\_mode](#input\_desync\_mitigation\_mode) | (Optional) Determines how the load balancer handles requests that might pose a security risk to an application due to HTTP desync. Valid values are `monitor`, `defensive` (default), `strictest`. | `string` | `"defensive"` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | (Optional) A health\_check block. | `map(string)` | `{}` | no |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | (Optional) The time in seconds that the connection is allowed to be idle. Default: `60` | `number` | `60` | no |
| <a name="input_instances"></a> [instances](#input\_instances) | (Optional) A list of instance ids to place in the ELB pool. | `list(string)` | `[]` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | (Optional) If true, ELB will be an internal ELB. | `bool` | `false` | no |
| <a name="input_listeners"></a> [listeners](#input\_listeners) | (Required) A list of listener blocks. | `list(any)` | `[]` | no |
| <a name="input_load_balancer_policies"></a> [load\_balancer\_policies](#input\_load\_balancer\_policies) | Load balancer policy resource block for single or multiple resources | `any` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the ELB. By default generated by Terraform. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with `name` | `string` | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | (Optional) A list of security group IDs to assign to the ELB. Only valid if creating an ELB within a VPC | `list(string)` | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Required for a VPC ELB) A list of subnet IDs to attach to the ELB. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the ELB |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | The DNS name of the ELB |
| <a name="output_id"></a> [id](#output\_id) | The name of the ELB |
| <a name="output_instances"></a> [instances](#output\_instances) | The list of instances in the ELB |
| <a name="output_name"></a> [name](#output\_name) | The name of the ELB |
| <a name="output_source_security_group"></a> [source\_security\_group](#output\_source\_security\_group) | The name of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances. Use this for Classic or Default VPC only. |
| <a name="output_source_security_group_id"></a> [source\_security\_group\_id](#output\_source\_security\_group\_id) | The ID of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances. Only available on ELBs launched in a VPC. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | The canonical hosted zone ID of the ELB (to be used in a Route 53 Alias record) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Third party software
This repository uses third party software:
* [pre-commit](https://pre-commit.com/) - Used to help ensure code and documentation consistency
  * Install with `brew install pre-commit`
  * Manually use with `pre-commit run`
* [terraform 0.14.11](https://releases.hashicorp.com/terraform/0.14.11/) For backwards compatibility we are using version 0.14.11 for testing making this the min version tested and without issues with terraform-docs.
* [terraform-docs](https://github.com/segmentio/terraform-docs) - Used to generate the [Inputs](#Inputs) and [Outputs](#Outputs) sections
  * Install with `brew install terraform-docs`
  * Manually use via pre-commit
* [tflint](https://github.com/terraform-linters/tflint) - Used to lint the Terraform code
  * Install with `brew install tflint`
  * Manually use via pre-commit

### Makefile
The makefile contained in this repo is optimized for linux paths and the main purpose is to execute testing for now.
* Create all tests stacks including any supporting resources:
```console
make tests
```
* Clean all tests *except* existing supporting resources:
```console
make clean
```
* Clean supporting resources - this is done separately so you can test your module build/modify/destroy independently.
```console
make cleansupporting
```
* !!!DANGER!!! Clean the state files from examples and test/supportingResources - use with CAUTION!!!
```console
make cleanstatefiles
```

#### BOLDLink-SIG 2023
