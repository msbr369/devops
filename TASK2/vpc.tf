provider "aws" {
  region = "us-west-1"
  access_key = ""
  secret_key = ""
}
resource "aws_vpc" "mainvpc" {
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "VPC_TF"
  }
}
resource "aws_subnet" "public_A" {
  vpc_id     = "${aws_vpc.mainvpc.id}"
  cidr_block = "192.168.0.0/18"
  availability_zone = "us-west-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_A"
  }
  depends_on = ["aws_vpc.mainvpc"]
}
resource "aws_subnet" "public_B" {
  vpc_id     = "${aws_vpc.mainvpc.id}"
  cidr_block = "192.168.64.0/18"
  availability_zone = "us-west-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_B"
  }
  depends_on = ["aws_vpc.mainvpc"]
}
resource "aws_subnet" "private_A" {
  vpc_id     = "${aws_vpc.mainvpc.id}"
  cidr_block = "192.168.128.0/18"
  availability_zone = "us-west-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "private_A"
  }
  depends_on = ["aws_vpc.mainvpc"]
}
resource "aws_subnet" "private_B" {
  vpc_id     = "${aws_vpc.mainvpc.id}"
  cidr_block = "192.168.192.0/18"
  availability_zone = "us-west-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "private_B"
  }
  depends_on = ["aws_vpc.mainvpc"]
}
