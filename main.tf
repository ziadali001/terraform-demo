provider "aws" {
    region = "us-east-1"
}

variable "subnet_cidr_block" {
    description = "subnet cidr block"
}

variable "vpc_cidr_block" {
    description = "vpc cidr block"
}

variable "enviroment" {
    description = "deployment enviroment"
}

resource "aws_vpc" "dev-vpc" {
    cidr_block = var.vpc_cidr_block.id
    tags = {
        Name: var.enviroment
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.dev-vpc.id 
    cidr_block = var.subnet_cidr_block
    availability_zone = "us-east-1a"
    tags = {
        Name: "subnet-dev-1"
    }
}

data "aws_vpc" "existing_vpc" {
    default = true 
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id 
    cidr_block = "172.31.96.0/20"
    availability_zone = "us-east-1a"
    tags = {
        Name: "subnet-dev-2"
    }
}

output "dev-vpc-id" {
  value = aws.vpc.dev-vpc.id
}
