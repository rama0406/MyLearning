provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "web" {
  ami           = "ami-006935d9a6773e4ec"
  instance_type = "t3.micro"
  availability_zone = "ap-south-1a"
  key_name = "champ"
  vpc_security_group_ids = [aws_security_group.TF_SG.id]
  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing httpd"
  sudo yum update -y
  sudo yum install httpd -y
  sudo  systemctl start httpd
  sudo systemctl enable httpd
  echo "*** Completed Installing httpd"
  EOF
  tags = { 
    Name = "Apache-1"
  }
}

resource "aws_instance" "web1" {
  ami           = "ami-006935d9a6773e4ec"
  instance_type = "t3.micro"
  availability_zone = "ap-south-1b"
  key_name = "champ"
  vpc_security_group_ids = [aws_security_group.TF_SG.id]
  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing httpd"
  sudo yum update -y
  sudo yum install httpd -y
  sudo  systemctl start httpd
  sudo systemctl enable httpd
  echo "*** Completed Installing apache2"
  EOF
  tags = {
    Name = "Apache-2"
  }
}


resource "aws_security_group" "TF_SG" {
  name        = "security group using Terraform"
  description = "security group using Terraform"
  vpc_id      = "vpc-022bf67127128c582"

  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    ingress {
    description      = "https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "TF_SG"
  }
 }
