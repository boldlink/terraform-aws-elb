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

# Terraform  module example of complete and most common configuration


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0, <= 5.15.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.15.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_access_logs_bucket"></a> [access\_logs\_bucket](#module\_access\_logs\_bucket) | boldlink/s3/aws | 2.3.0 |
| <a name="module_complete_elb"></a> [complete\_elb](#module\_complete\_elb) | ../../ | n/a |
| <a name="module_ec2_instances"></a> [ec2\_instances](#module\_ec2\_instances) | boldlink/ec2/aws | 2.0.3 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | boldlink/vpc/aws | 3.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_security_group.elb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [tls_private_key.example](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.example](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_elb_service_account.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/elb_service_account) | data source |
| [aws_iam_policy_document.elb_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs_sse_algorithm"></a> [access\_logs\_sse\_algorithm](#input\_access\_logs\_sse\_algorithm) | The server-side encryption algorithm to use for the elb access logs bucket. Valid values are `AES256` and `aws:kms` | `string` | `"AES256"` | no |
| <a name="input_architecture"></a> [architecture](#input\_architecture) | The architecture of the instance to launch | `string` | `"x86_64"` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | (Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length`. | `string` | `"10.1.0.0/16"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the ELB | `string` | `"complete-example-elb"` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | Configuration block to customize details about the root block device of the instance. | `list(any)` | <pre>[<br>  {<br>    "encrypted": true,<br>    "volume_size": 15<br>  }<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the resources | `map(string)` | <pre>{<br>  "Department": "DevOps",<br>  "Environment": "example",<br>  "LayerId": "cExample",<br>  "LayerName": "cExample",<br>  "Owner": "Boldlink",<br>  "Project": "Examples",<br>  "user::CostCenter": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_outputs"></a> [outputs](#output\_outputs) | Various output values for this module |
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

#### BOLDLink-SIG 2023
