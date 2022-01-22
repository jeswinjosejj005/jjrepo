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