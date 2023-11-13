variable "access_logs_sse_algorithm" {
  type        = string
  description = "The server-side encryption algorithm to use for the elb access logs bucket. Valid values are `AES256` and `aws:kms`"
  default     = "AES256"
}

variable "name" {
  type        = string
  description = "The name of the ELB"
  default     = "complete-example-elb"
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

variable "root_block_device" {
  description = "Configuration block to customize details about the root block device of the instance."
  type        = list(any)
  default = [
    {
      volume_size = 15
      encrypted   = true
    }
  ]
}

variable "architecture" {
  type        = string
  description = "The architecture of the instance to launch"
  default     = "x86_64"
}

variable "cidr_block" {
  type        = string
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length`."
  default     = "10.1.0.0/16"
}
