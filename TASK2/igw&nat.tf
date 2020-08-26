resource "aws_internet_gateway" "IGW_TF" {
  vpc_id = "${aws_vpc.mainvpc.id}"
  tags = {
    Name = "IGW_TF"
  }
  depends_on = ["aws_vpc.mainvpc"]
}
resource "aws_eip" "EIP" {
    vpc = true
    tags = {
        Name = "EIP"
    }
}
resource "aws_nat_gateway" "NATGW" {
  allocation_id = "${aws_eip.EIP.id}"
  subnet_id     = "${aws_subnet.public_A.id}"

  tags = {
    Name = "NATGW"
  }
  depends_on = ["aws_eip.EIP","aws_subnet.public_A"]
}