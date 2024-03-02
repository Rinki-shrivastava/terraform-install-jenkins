resource "aws_instance" "node" {
  ami             = var.aws_instance-node-ami
  instance_type   = var.aws_instance-node-instance_type
  key_name        = var.aws_instance-node-key_name
  vpc_security_group_ids = [aws_security_group.jks-sg.id]
  subnet_id       = var.aws_instance-node-subnet_id
  iam_instance_profile = var.aws_instance-node-iam_instance_profile
  user_data       = <<-EOF
    #!/bin/bash
    sudo -i
    sudo apt update
    sudo apt install openjdk-11-jre-headless -y
    EOF

  tags = {
    Name = "tf-jks-node-instance"
  }
}

# create new security group
resource "aws_security_group" "jks-sg" {
  vpc_id = var.aws_security_group-jks-sg-vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "tf-jks-sg"
  }
}