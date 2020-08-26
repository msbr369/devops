resource "aws_route_table" "publicrt" {
  vpc_id = "${aws_vpc.mainvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.IGW_TF.id}"
  }
  tags = {
    Name = "publicrt"
  }
  depends_on = ["aws_vpc.mainvpc","aws_internet_gateway.IGW_TF"]
}
resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.public_A.id}"
  route_table_id = "${aws_route_table.publicrt.id}"
  depends_on = ["aws_subnet.public_A","aws_route_table.publicrt"]
}
resource "aws_route_table_association" "b" {
  subnet_id      = "${aws_subnet.public_B.id}"
  route_table_id = "${aws_route_table.publicrt.id}"
  depends_on = ["aws_subnet.public_B","aws_route_table.publicrt"]
}
resource "aws_route_table" "privatert" {
  vpc_id = "${aws_vpc.mainvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.NATGW.id}"
  }
  tags = {
    Name = "privatert"
  }
  depends_on = ["aws_vpc.mainvpc","aws_nat_gateway.NATGW"]
}
resource "aws_route_table_association" "c" {
  subnet_id      = "${aws_subnet.private_A.id}"
  route_table_id = "${aws_route_table.privatert.id}"
  depends_on = ["aws_subnet.private_A","aws_route_table.privatert"]
}
resource "aws_route_table_association" "d" {
  subnet_id      = "${aws_subnet.private_B.id}"
  route_table_id = "${aws_route_table.privatert.id}"
  depends_on = ["aws_subnet.private_B","aws_route_table.privatert"]
}









