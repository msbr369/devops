resource "aws_instance" "publicec2" {
  ami           = "ami-0a780d5bac870126a"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  subnet_id =  "${aws_subnet.public_A.id}"
  key_name   = ""
  tags = {
    Name = "publicec2"
  }
  depends_on = ["aws_vpc.mainvpc","aws_subnet.public_A"]
}
user_data = <<-EOF
              yum ypdate -y
              yum install -y httpd
              systemctl start httpd.service
              systemctl enable httpd.service
              sudo amazon-linux-extras install -y php7.2
              sudo yum install -y php-dom php-gd php-simplexml php-xml php-opcache php-mbstring
              sudo yum install -y php-pgsql
              wget https://www.drupal.org/download-latest/tar.gz
              mv drupal-* drupal
              ls
              cd drupal
              sudo rsync -avz . /var/www/html
              sudo chown -R apache:apache /var/www/html
              sudo services httpd restart
              EOF