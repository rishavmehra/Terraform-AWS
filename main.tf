terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = "xxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxx"
}


# input variable  
# variable "subnet_cidr_block" {
#   description = "subnet cidr block"
#   default = "10.0.10.0/24" # it is not define in the .tfvars file
#   type = string
# }
variable "cidr_block" {
  description = "cidr block for vpc and subnets"
  type = list(string)
  # type =list(object({
  #   cidr_block=string
  #   name = string
  # }))
}




variable "vpc_cidr_block" {
  description = "vpc cidr block"
  
}
variable "enviroment" {
  description = "deployement enviroment"
  
}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name: var.enviroment
  }
}
resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "subnet-1-dev"
  }
}

# resource "aws_vpc" "development-vpc" {
#   cidr_block = var.cidr_block[0]
#   tags = {
#     Name: var.enviroment
#   }
# }

# resource "aws_subnet" "dev-subnet-1" {
#   vpc_id = aws_vpc.development-vpc.id
#   cidr_block = var.cidr_block[1]
#   availability_zone = "us-east-1a"
#   tags = {
#     "Name" = "subnet-1-dev"
#   }
# }


# data "aws_vpc" "exsting-vpc" {
#   default = true
# }
# resource "aws_subnet" "dev-subnet-2" {
#   vpc_id = data.aws_vpc.exsting-vpc.id
#   cidr_block = "172.31.96.0/20"
#   availability_zone = "us-east-1a"
#   tags = {
#     "Name" = "subnet-2-default"
#   }
# }

# output "dev-vpc-id" {
#   value = aws_vpc.development-vpc.id
# }

# output "dev-subnet-id" {
#   value = aws_subnet.dev-subnet-1.id
# }