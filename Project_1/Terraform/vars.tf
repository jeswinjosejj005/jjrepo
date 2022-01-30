variable "region" {
  default = "us-east-2"
}
variable "private_key_path" {
  default = "winkp.pem"
}

variable "ami_id" {
  type = map
  default = {
    us-east-2    = "ami-03a0c45ebc70f98ea"
    us-west-2    = "ami-09889d8d54f9e0a0e"
    eu-central-1 = "ami-9787h5h6nsn"
  }
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}


variable "enable_classiclink" {
  description = "Should be true to enable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type        = bool
  default     = false
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}
