# node instance variables 

variable "aws_instance-node-ami" {
  type = string
}

variable "aws_instance-node-instance_type" {
  type = string
}

variable "aws_instance-node-key_name" {
  type = string
}

variable "aws_instance-node-subnet_id" {
  type = string
}

variable "aws_instance-node-iam_instance_profile" {
  type = string
}

variable "aws_security_group-jks-sg-vpc_id" {
  type = string
}