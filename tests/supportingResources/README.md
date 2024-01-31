[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# terraform-aws-elb supporting resources

These stacks are to be used on the examples testing and where setup to minimum dependencies,
they are not in any way the recommended setup for a production grade implementation.


This stack builds:
* VPC with public and Private subnets

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.15.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_elb_vpc"></a> [elb\_vpc](#module\_elb\_vpc) | boldlink/vpc/aws | 3.0.4 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | VPC CIDR | `string` | `"10.1.0.0/16"` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Whether to enable dns hostnames | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Whether to enable dns support for the vpc | `bool` | `true` | no |
| <a name="input_enable_public_subnets"></a> [enable\_public\_subnets](#input\_enable\_public\_subnets) | Whether to enable public subnets | `bool` | `true` | no |
| <a name="input_map_public_ip_on_launch"></a> [map\_public\_ip\_on\_launch](#input\_map\_public\_ip\_on\_launch) | Whether assign public IPs by default to instances launched on subnet | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the stack | `string` | `"terraform-aws-elb"` | no |
| <a name="input_nat"></a> [nat](#input\_nat) | Choose `single` or `multi` for NATs | `string` | `"single"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the created resources | `map(string)` | <pre>{<br>  "Department": "DevOps",<br>  "Environment": "examples",<br>  "LayerId": "cExample",<br>  "LayerName": "cExample",<br>  "Owner": "Boldlink",<br>  "Project": "Examples",<br>  "user::CostCenter": "terraform-registry"<br>}</pre> | no |

## Outputs

No outputs.
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

### Supporting resources:

The example stacks are used by BOLDLink developers to validate the modules by building an actual stack on AWS.

Some of the modules have dependencies on other modules (ex. Ec2 instance dependns on the VPC) so we create them
first and use data sources on the examples to use the stacks.

Any supporting resources will be available on the `tests/supportingResources` and the lifecycle is managed by the `Makefile` targets.

### Makefile
The makefile contain in this repo is optimised for linux paths and the main purpose is to execute testing for now.
* Create all tests stacks including any supporting resources:
```console
make tests
```
* Clean all tests *except* existing supporting resources:
```console
make clean
```
* Clean supporting resources - this is done seperatly so you can test your module build/modify/destroy independatly.
```console
make cleansupporting
```

#### BOLDLink-SIG 2024