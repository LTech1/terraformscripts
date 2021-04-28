resource "aws_instance" "server1" {
    ami = "xxx"
    instance_type = "t2.micro"
    key_name  =  "key"
    tags  = {
        Name = "dbserver"
        Environment = "dev"
        Team = "Developers"
    }
  
}


resource "aws_instance" "app_servers" {
    key_name = "April"
    iam_instance_profile = "KOPS"
    ami = "ami-03d64741867e"
    instance_type = "t2.micro"

    tags = {
      "name" = "app_servers"
    }
    
}
