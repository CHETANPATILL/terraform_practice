terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

variable subnet_cidr_block {
  default     = "10.0.10.0/24"
  description = "Subnet cidr block"
}


resource "aws_vpc" "development-vpc" {
    cidr_block= "10.0.0.0/16"
    tags={
        Name: "Development"
        vpc_env: "dev"
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = "ap-south-1a"
    tags={
        Name: "subnet-1-dev"
    }
}

data "aws_vpc" "existing_vpc" {
    default=true
}
