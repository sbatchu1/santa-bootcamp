provider "aws" {
  region = "ap-south-1"
  profile = "ShellPowerUser"
}

module "santa-sg-eks" {
  source = "../module/sg/"
}

module "santa-vpc-eks" {
  source = "../module/vpc/"
}

module "santa-eks-eks" {
  source = "../module/eks-cluster/"
  mike_is_awesome = [module.santa-vpc-eks.santa_first_subnet, module.santa-vpc-eks.santa_second_subnet]
  default-vpc = module.santa-vpc-eks.vpc_id
  }

module "santa-ecr" {
  source = "../module/ecr"
}
