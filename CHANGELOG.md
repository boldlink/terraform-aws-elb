# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- Feature: Adding acm certificate for ssl

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

[1.0.0]: https://github.com/boldlink/terraform-aws-elb/releases/tag/1.0.0
