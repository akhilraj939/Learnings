variable "region" {
  default = "us-east-1"
}


variable "cidr_block" {
  default = "10.0.0.0/24"
}

variable "tenancy" {
  default = "default"
}

variable "dnshost" {
  default = "true"
}

variable "subcidr" {
  default = "10.0.0.0/24"
}

variable "ami" {
  default = "ami-08f3d892de259504d"
}

variable "instancetype" {
  default = "t2.micro"
}

