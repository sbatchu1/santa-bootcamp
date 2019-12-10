terraform {
  backend "s3" {
    bucket = "santa-s3-bucket"
    key = "k8s-mike/terraform.tfstate"
    region = "ap-south-1"
    profile = "ShellPowerUser"
  }
}
