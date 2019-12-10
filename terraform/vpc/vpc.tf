resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_vpc}"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Environment = "${var.environment_tag}"
    Name = "Santa-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Environment = "${var.environment_tag}"
    Name = "Santa-igw"
  }
}


resource "aws_subnet" "subnet_public_1" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.cidr_subnet_1}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.availability_zone_1}"
  tags = {
    Environment = "${var.environment_tag}"
    Name = "Santa-subnet"
  }
}

resource "aws_subnet" "subnet_public_2" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.cidr_subnet_2}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.availability_zone_2}"
  tags = {
    Environment = "${var.environment_tag}"
    Name = "Santa-subnet"
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = "${aws_vpc.vpc.id}"
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw.id}"
  }
tags = {
    Environment = "${var.environment_tag}"
    Name = "Santa-rt"
  }
}

resource "aws_route_table_association" "rta_subnet_public_1" {
  subnet_id      = "${aws_subnet.subnet_public_1.id}"
  route_table_id = "${aws_route_table.rtb_public.id}"
}

resource "aws_route_table_association" "rta_subnet_public_2" {
  subnet_id      = "${aws_subnet.subnet_public_2.id}"
  route_table_id = "${aws_route_table.rtb_public.id}"
}

resource "aws_security_group" "sg_22" {
  name = "sg_22"
  vpc_id = "${aws_vpc.vpc.id}"
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Environment = "${var.environment_tag}"
    Name = "Santa-sg"
  }
}

resource "aws_key_pair" "ec2key" {
  key_name = "publicKey"
  public_key = "${file(var.public_key_path)}"
}

# resource "aws_instance" "testInstance" {
#   ami           = "${var.instance_ami}"
#   instance_type = "${var.instance_type}"
#   subnet_id = "${aws_subnet.subnet_public.id}"
#   vpc_security_group_ids = ["${aws_security_group.sg_22.id}"]
#   key_name = "${aws_key_pair.ec2key.key_name}"
#  tags = {
#   Environment = "${var.environment_tag}"
#  }
# }


module "santa-cluster" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = "santa-cluster"
  subnets      = ["${aws_subnet.subnet_public_1.id}", "${aws_subnet.subnet_public_2.id}"]
  vpc_id       = "${aws_vpc.vpc.id}"
  cluster_security_group_id  = "${aws_security_group.sg_22.id}"

  worker_groups = [
    {
      instance_type = "m4.large"
      asg_max_size  = 5
      tags = [{
        key                 = "santa"
        value               = "banta"
        propagate_at_launch = true
      }]
    }
  ]

  tags = {
    environment = "test"
  }
}