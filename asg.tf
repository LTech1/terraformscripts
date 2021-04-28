terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "us-west-2"
  access_key = "AKIAX6AHFZ4CAA2CP74W"
  secret_key = "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"

}

locals {
  availability_zones = "us-west-2c"
}

resource "aws_elb" "bmo-elb" {
  name = "bmo"

  # The same availability zone as our instances
  availability_zones = "us-west-2c"

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
}

resource "bmo-asg" "bmo-orillia-asg" {
  availability_zones   = "us-west-2a"
  name                 = "bmo-orillia"
  max_size             = 4
  min_size             = 2
  desired_capacity     = 2
  force_delete         = true
  launch_configuration = aws_launch_configuration.web-lc.name
  load_balancers       = [aws_elb.web-elb.name]

  #vpc_zone_identifier = ["${split(",", var.availability_zones)}"]
  tag {
    key                 = "Name"
     Name               = "bmo"
    propagate_at_launch = "true"
  }
}

resource "aws_launch_configuration" "web-lc" {
  name          = "terraform-example-lc"
  image_id      = var.aws_amis[var.aws_region]
  instance_type = var.instance_type

  # Security group
  security_groups = [bmo-SG]
  key_name        = "April"
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "default" {
  name        = "terraform_example_sg"
  description = "Used in the terraform"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
