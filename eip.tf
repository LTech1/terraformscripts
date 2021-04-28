resource "aws_eip" "webEIP" {
    instance = "${aws_instance.server1.id}"
  
}

# public, eip, and private

output "myeip" {
    value = "aws_eip.webEIP.public_ip"
  
}

output "serverIP" {
    value = aws_instance.server1.associate_with_private_ip
  
}