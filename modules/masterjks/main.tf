resource "aws_instance" "inst" {
  ami             = var.aws_instance-inst-ami
  instance_type   = var.aws_instance-inst-instance_type
  key_name        = var.aws_instance-inst-key_name
  vpc_security_group_ids = [aws_security_group.jks-sg.id]
  subnet_id       = var.aws_instance-inst-subnet_id
  iam_instance_profile = var.aws_instance-inst-iam_instance_profile
  user_data       = <<-EOF
    #!/bin/bash
    sudo -i
    sudo apt update
    sudo apt install openjdk-11-jre-headless -y
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins -y
    EOF

  tags = {
    Name = "tf-jks-instance"
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