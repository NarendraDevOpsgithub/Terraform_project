provider "aws" {
  region = "us-east-1"
  access_key = "AKIA47CRXTCGXXVACR4Q"
  secret_key = "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"
}
resource "aws_instance" "one" {
  ami                    = "ami-08a0d1e16fc3f61ea"
  instance_type          = "t2.micro"
  key_name               = "NLinux"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone      = "us-east-1a"
  user_data              = <<EOF
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "Hi all this is my first terraform project using jenkins pipeline through amazon linux 2 in server in 1" > /var/www/html/index.html
EOF
  tags = {
    Name = "Narendra-1"
  }
}
resource "aws_instance" "two" {
  ami                    = "ami-08a0d1e16fc3f61ea"
  instance_type          = "t2.micro"
  key_name               = "NLinux"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone      = "us-east-1b"
  user_data              = <<EOF
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "Hi all this is my first terraform project using jenkins pipeline through amazon linux 2 in server in 2" > /var/www/html/index.html
EOF
  tags = {
    Name = "Narendra-2"
  }
}

resource "aws_security_group" "three" {
  name = "elb_sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
