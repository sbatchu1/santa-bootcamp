terraform {
  backend "s3" {
    bucket  = "santa-s3-bucket"
    key     = "vpc/terraform.tfstate"
    region  = "ap-south-1"
    profile = "ShellPowerUser"
  }
}

provider "aws" {
  region  = "ap-south-1"
  profile = "ShellPowerUser"
}