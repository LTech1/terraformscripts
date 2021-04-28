resource "aws_instance" "server1" {
    ami = "xxx"
    instance_type = "t2.micro"
    key_name  =  "key"
    tags  = {
        Name = "dbserver"
        Environment = "development"
        Team = "Developers"
    }
  
}
