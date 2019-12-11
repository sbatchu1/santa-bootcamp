# main file for Jenkins master creation
# Saving state file in backend s3 bucket
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
# defining the ami for Jenkins server creation
variable "ami" {
  type        = "string"
  default     = "ami-0acff51c40957b3c4"
  description = "santa-jenkins-image id"
}
# calling master module for SG, VPC creation
module "pt_master_module" {
  source = "./module/master"
}
