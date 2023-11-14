variable "name" {
  type        = string
  description = "The name of the ELB"
  default     = "minimum-example-elb"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the resources"
  default = {
    Environment        = "example"
    "user::CostCenter" = "terraform"
    Department         = "DevOps"
    Project            = "Examples"
    Owner              = "Boldlink"
    LayerName          = "cExample"
    LayerId            = "cExample"
  }
}

variable "supporting_resources_name" {
  type        = string
  description = "Name of the supporting resources"
  default     = "terraform-aws-elb"
}
