

variable "vpc_a_name" {
  type = string
  default = "VPC-A"
}

variable "vpc_a_cidr" {
  type = string
  default = "10.0.0.0/16"
}


variable "vpc_b_name" {
  type = string
  default = "VPC-B"
}

variable "vpc_b_cidr" {
  type = string
  default = "10.1.0.0/16"
}

variable "availability_zone" {
  type = list(string)
  default = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
}