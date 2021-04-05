provider "aws" {
    region = var.region
    profile = var.profile
}

resource "aws_security_group" "ansible-newSG" {
    name = "ansible-newSG"
    vpc_id = "vpc-a50ccfd8"
    description = "New Sec Group"
    ingress {
    description = ""
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = ""
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = ""
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["your ip address"]
  }
    egress {
    description = ""
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = false
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "site" {
    ami = "ami-042e8287309f5df03"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.ansible-newSG.name]
    key_name = "ansible_newsec"
        tags = {
            Name = var.name
            group = var.group
        }
}
