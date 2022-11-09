#General Data
data "aws_region" "current" {}

#General Variables
variable "env" {
  description = "The environment of the project"
  default     = "test"
}

variable "app" {
  description = "The app of the project"
  default     = "my_app"
}

variable "aws_profile" {
  description = "aws profile"
}

variable "aws_dns" {
  type    = bool
  default = true
}

#Variables for Application Load Balancer
variable "app_port" {
  description = "The application port"
  default     = 80
}

variable "app_target_port" {
  description = "The application port"
  default     = 80
}

variable "health_check_path" {
  description = "The path for health check web servers"
  default     = "/"
}

#Variables for ECR
data "aws_caller_identity" "current" {}

locals {
  aws_account_id = data.aws_caller_identity.current.account_id
}

variable "name_container" {
  description = "The container name"
  default     = "nginx"
}

#Variables for ECS
variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "TaskExecutionRole"
}

variable "ecs_task_role_name" {
  description = "ECS task role name"
  default     = "TaskRole"
}

variable "web_server_image" {
  description = "The web server image to run in the ECS cluster"
  default     = "089370973671.dkr.ecr.eu-central-1.amazonaws.com/my_app-test-nginx"
}

variable "web_server_count" {
  description = "Number of web server containers to run"
  default     = 1
}

variable "web_server_fargate_cpu" {
  description = "Fargate instance CPU units to provision for web server (1 vCPU = 1024 CPU units)"
  default     = 256
}

variable "web_server_fargate_memory" {
  description = "Fargate instance memory to provision for web server (in MiB)"
  default     = 512
}

variable "ecr_repository_url" {
  type = string
}

variable "image_tag" {
  type = string
}

locals {
  image = format("%s:%s", var.ecr_repository_url, var.image_tag)
}

variable "taskdef_template" {
  default = "cb_app.json.tpl"
}

variable "remote_state_bucket" {}

variable "aws_region" {
  default = "eu-central-1"
  type    = string
}
variable "cidr_block_vpc" {
  description = "CIDR Block for VPC"
  default     = "10.0.0.0/16"
  type        = string
}

variable "PublicRouteTable" {
  type = map(object({
    cidr_block = string
    tags       = map(string)
  }))
  default = {
    Public1 = {
      cidr_block = "0.0.0.0/0"
      tags = {
        "Name" = "Public Route Table"
      }
    }
    Public2 = {
      cidr_block = "0.0.0.0/0"
      tags = {
        "Name" = "Public Route Table"
      }
    }
  }
}
variable "PrivateRouteTable" {
  type = map(object({
    cidr_block = string
    tags       = map(string)
  }))
  default = {
    Private1 = {
      cidr_block = "0.0.0.0/0"
      tags = {
        "Name" = "Private Route Table"
      }
    }
    Private2 = {
      cidr_block = "0.0.0.0/0"
      tags = {
        "Name" = "Private Route Table"
      }
    }
  }
}

variable "cidr_block" {
  description = "CIDR Block for Access from and to Internet"
  default     = "0.0.0.0/0"
  type        = string
}
variable "public_subnets" {
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    tags                    = map(string)
  }))
  default = {
    Public1 = {
      cidr_block              = "10.0.3.0/24"
      availability_zone       = "eu-central-1a"
      map_public_ip_on_launch = true
      tags = {
        "Name" = "Public Subnet 1"
      }
    }
    Public2 = {
      cidr_block              = "10.0.4.0/24"
      availability_zone       = "eu-central-1b"
      map_public_ip_on_launch = true
      tags = {
        "Name" = "Public Subnet 2"
      }
    }
  }
}
variable "private_subnets" {
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    tags                    = map(string)
  }))
  default = {
    "Private1" = {
      cidr_block              = "10.0.1.0/24"
      availability_zone       = "eu-central-1a"
      map_public_ip_on_launch = false
      tags = {
        "Name" = "Private Subnet 1"
      }
    }
    "Private2" = {
      cidr_block              = "10.0.2.0/24"
      availability_zone       = "eu-central-1b"
      map_public_ip_on_launch = false
      tags = {
        "Name" = "Private Subnet 2"
      }
    }
  }
}