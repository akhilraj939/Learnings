provider "aws" {
  region = "${var.region}"
  access_key = ""
  secret_key = ""
}

resource "aws_vpc" "newvpc" {
  cidr_block = "${var.cidr_block}"
 # instance_tenancy = "${var.tenancy)"
  enable_dns_hostnames = "${var.dnshost}"
}

resource "aws_subnet" "newsubnet" {
  vpc_id = "${aws_vpc.newvpc.id}"
  cidr_block = "${var.subcidr}"
}

resource "aws_instance" "new" {
  ami = "${var.ami}"
  instance_type = "${var.instancetype}"
  subnet_id = "${aws_subnet.newsubnet.id}"
}

output "vpc_id" {
  value = "${aws_vpc.newvpc.id}"
}

output "tenancy" {
  value = "${aws_vpc.newvpc.instance_tenancy}"
}

output "cidr" {
  value = "${aws_vpc.newvpc.cidr_block}"
}

output "instance_id" {
  value = "${aws_instance.new.id}"
}

output "arn" {
  value = "${aws_instance.new.arn}"
}

output "AZ" {
  value = "${aws_instance.new.availability_zone}"
}

terraform {
  backend "s3" {
   bucket = "cloud1234akhil"
   key = "plan"
   region = "us-east-1"
 }
}
