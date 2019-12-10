resource "aws_default_subnet" "default_az1" {
  availability_zone = "${var.region}a"
  tags = {
    Name = "Default subnet for ${var.region}"
  }
}
resource "aws_default_subnet" "default_az2" {
  availability_zone = "${var.region}b"
  tags = {
    Name = "Default subnet for ${var.region}"
  }
}


module "my-cluster"{
  source       = "github.com/terraform-aws-modules/terraform-aws-eks.git"
  cluster_name = "santa-is-awesome-eks-cluster"
  subnets      = [aws_default_subnet.default_az2.id, aws_default_subnet.default_az1.id]
  vpc_id       = var.default-vpc

  worker_groups = [
    {
      instance_type = "t3.medium"
      asg_max_size  = 5
      tags = [{
        key                 = "Owner"
        value               = "santa"
        propagate_at_launch = true
      }]
    }
  ]
tags = {
    Environment = "Non-Production"
    Owner = "santa"
  }

}