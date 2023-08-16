# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- Feature: Adding acm certificate for ssl
- fix: CKV_AWS_92  #Ensure the ELB has access logging enabled. For the minimal example, this is not enabled
- fix: CKV_AWS_144 #Ensure that S3 bucket has cross-region replication enabled
- fix: CKV_AWS_18  #Ensure the S3 bucket has access logging enabled
- fix: CKV_AWS_145 #Ensure that S3 buckets are encrypted with KMS by default:: We are using the default `aws/s3`. This can be overwriten by providing the value of `access_logs_kms_id`
- fix: CKV2_AWS_61 #"Ensure that an S3 bucket has a lifecycle configuration"
- fix: CKV2_AWS_62 #"Ensure S3 buckets should have event notifications enabled"
- fix: CKV2_AWS_6 #"Ensure that S3 bucket has a Public Access block"
- fix: CKV_AWS_21 #"Ensure all data stored in the S3 bucket have versioning enabled"

## [1.1.1] - 2023-08-16
- fix: added checkov exceptions to `.checkov.yaml` file

## [1.1.0] - 2022-05-26
### Added
- Added the `.github/workflow` folder
- Re-factored examples (`minimum`, `complete` and additional)
- Added `CHANGELOG.md`
- Added `CODEOWNERS`
- Added `versions.tf`, which is important for pre-commit checks
- Added `Makefile` for examples' automation
- Added `.gitignore` file
- Added `.checkov.yml` file to skip checkov designed checks

## [1.0.0] - 2022-04-07
### Added
- Feature: load balancer policy
- Feature: s3 resource when access logs is enabled
- Feature: load balancer configurations
- Initial Commit

[1.0.0]: https://github.com/boldlink/terraform-aws-elb/releases/tag/1.1.1

[1.0.0]: https://github.com/boldlink/terraform-aws-elb/releases/tag/1.0.0
[1.1.0]: https://github.com/boldlink/terraform-aws-elb/releases/tag/1.1.0
[1.1.1]: https://github.com/boldlink/terraform-aws-elb/releases/tag/1.1.1
