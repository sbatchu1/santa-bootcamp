terraform {
  backend "s3" {
    bucket  = "santa-s3-bucket"
    key     = "santa-ecr-state.tfstate"
    region  = "ap-south-1"
    profile = "ShellPowerUser"
  }
}


provider "aws" {
  version = ">= 2.28.1"
  region  = "ap-south-1"
  profile = "ShellPowerUser"
}

resource "aws_ecr_repository" "webapp" {
  name                 = "santa/webapp"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


resource "aws_ecr_repository" "apigateway" {
  name                 = "santa/apigateway"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "position-simulator" {
  name                 = "santa/position-simulator"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "position-tracker" {
  name                 = "santa/position-tracker"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "queue" {
  name                 = "santa/queue"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
