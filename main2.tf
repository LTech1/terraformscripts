#main.tf
# HCL 
provider "aws" {
  region     = "ca-central-1"

}
# vpc.tf
resource "aws_vpc" "vpc23" {
    cidr_block = "10.10.0.0/20"
    tags = {
        Name = "myvpc23"
        Environment = "dev"
    }
}
# ec2.tf 
resource "aws_instance" "server1" {
    ami           = "ami-08523c5075ba75813"
    instance_type = "t2.micro"
    key_name      = "classkey"
    tags = {
        Name = "dbserver"
        Environment = "dev"
    }
  
}
resource "aws_s3_bucket" "mys3" {
  bucket = "class23"
  acl    = "private"

  tags = {
    Name        = "class23abc"
    Environment = "Dev"
  }
}

resource "aws_eip" "webEIP" {
  instance = "${aws_instance.server1.id}"
}
# Public Ip , privateIP, EIP 


output "myEIP" {
  value = aws_eip.webEIP.public_ip
}
output "serverIP" {
  value = aws_instance.server1.private_ip
}

output "serverpublicIP" {
  value = aws_instance.server1.public_ip
}


