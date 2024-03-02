module "masterjks" {
  source = "./modules/masterjks"

    aws_instance-inst-ami = "ami-0c7217cdde317cfec"
    aws_instance-inst-instance_type = "t2.micro"
    aws_instance-inst-key_name = "3tier-key"
    aws_instance-inst-subnet_id = "subnet-04e4c81a9753a064d"
    aws_security_group-jks-sg-vpc_id = "vpc-036e263d7aa163bd2"
    # aws_instance-inst-vpc_security_group_ids = "[aws_security_group.jks-sg.id]"
    aws_instance-inst-iam_instance_profile = "ec2-cft-vpc-fullaccess"
  }

module "nodejks" {
    source = "./modules/nodejks"

    aws_instance-node-ami = "ami-0c7217cdde317cfec"
    aws_instance-node-instance_type = "t2.micro"
    aws_instance-node-key_name = "3tier-key"
    aws_instance-node-subnet_id = "subnet-09f1e58f793c59325"
    aws_instance-node-iam_instance_profile = "ec2-cft-vpc-fullaccess"
    aws_security_group-jks-sg-vpc_id = "vpc-036e263d7aa163bd2"
  
}