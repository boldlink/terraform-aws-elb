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

# Terraform  module example of the minimum configuration


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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_elb"></a> [elb](#module\_elb) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.supporting](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the ELB | `string` | `"minimum-example-elb"` | no |
| <a name="input_supporting_resources_name"></a> [supporting\_resources\_name](#input\_supporting\_resources\_name) | Name of the supporting resources | `string` | `"terraform-aws-elb"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the resources | `map(string)` | <pre>{<br>  "Department": "DevOps",<br>  "Environment": "example",<br>  "LayerId": "cExample",<br>  "LayerName": "cExample",<br>  "Owner": "Boldlink",<br>  "Project": "Examples",<br>  "user::CostCenter": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_outputs"></a> [outputs](#output\_outputs) | ELB values for the module |
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

#### BOLDLink-SIG 2024
