terraform {
  backend "s3" {
    bucket  = "santa-s3-bucket"
    key     = "team-santa"
    region  = "ap-south-1"
    profile = "ShellPowerUser"
  }
}

provider "aws" {
  region  = "ap-south-1"
  profile = "ShellPowerUser"
}

variable "ami" {
  type        = string
  default     = "ami_ID"
  description = "ami_ID"
}
module "pt_master_module" {
  source = "./module/master"
  # var.ami = "ami-0ca4ee4403ecb3a4e"
}

# module "pt_node_module" {
#    source = "./module/node"
  #  var.ami = "ami-0612808b4a0ca35a1"
#  }
