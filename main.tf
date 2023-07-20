provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "web" {
  ami           = "ami-006935d9a6773e4ec"
  instance_type = "t3.micro"

  tags = {
    Name = "champ_client"
  }
}
