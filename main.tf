terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}
provider "aws" {
  region = "us-east-2"
  access_key = "AKIARNKVYT4YJ7B5G3HS"
  secret_key = "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"
}

resource "aws_instance" "aws-jenkins-ec2" {
  ami = "ami-0b8b44ec9a8f90422"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  tags = {
    Name = "Jenkins_Server"
  }

user_data = <<-EOF
#!bin/bash
    sudo yum update -y
    sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    sudo yum upgrade
    sudo amazon-linux-extras install java-openjdk11 -y
    sudo dnf install java-11-amazon-corretto -y
    sudo yum install jenkins -y
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
  EOF
}


