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
  type        = "string"
  default     = "ami-0acff51c40957b3c4"
  description = "santa-jenkins-image id"
}
module "pt_master_module" {
  source = "./module/master"
  # var.ami = "ami-0ca4ee4403ecb3a4e"
}

# module "pt_node_module" {
#    source = "./module/node"
  #  var.ami = "ami-0612808b4a0ca35a1"
#  }
