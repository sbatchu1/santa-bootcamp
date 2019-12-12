# defining attributes for Jenkins server
resource "aws_instance" "pt_master_module" {
  ami                    =  "ami-0acff51c40957b3c4"
  instance_type          = "t3.medium"
  vpc_security_group_ids = ["${aws_security_group.sg_jenkins.id}"]
  # aws_security_group = "${aws_security_group.sg_jenkins.name}"
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
  key_name = "master-key"
  tags = {
    Name = "Jenkins Master_Santa"
  }
}
# defininf SG
resource "aws_security_group" "sg_jenkins" {
  name        = "sg2"
  description = "Allows all traffic"

  tags = {
    Name = "Santa-Jenkins-SG"
    Owner = "Santa"
  }

  # SSH
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  # HTTP
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }


# HTTP
  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  # Jenkins JNLP port
  ingress {
    from_port = 50000
    to_port   = 50000
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }


  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
}


output "instance_id" {
  value = "${aws_instance.pt_master_module.id}"
}
# defining user profile for the server
resource "aws_iam_instance_profile" "test_profile" {
  name = "santa_profile"
  role = "SantaPowerUser"
}


resource "aws_iam_role_policy" "eks_policy" {
  name = "eks_policy"
  role = "${aws_iam_role.test_role.id}"

  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "EKSPolicy",
            "Effect": "Allow",
            "Action": "eks:*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "s3_policy" {
  name = "s3_policy"
  role = "${aws_iam_role.test_role.id}"

  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Deny",
            "Action": "s3:delete*",
            "Resource": [
                "arn:aws:s3:::terraform-trainers-remote-state/*",
                "arn:aws:s3:::terraform-trainers-remote-state"
            ]
        }
    ]
}
EOF
}


resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_policy"
  role = "${aws_iam_role.test_role.id}"

  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:*",
                "autoscaling:*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Deny",
            "Action": "ec2:*",
            "Resource": "*",
            "Condition": {
                "StringNotEquals": {
                    "ec2:InstanceType": [
                        "t2.micro",
                        "t3.medium"
                    ],
                    "ec2:Region": "ap-south-1"
                }
            }
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "elb_policy" {
  name = "elb_policy"
  role = "${aws_iam_role.test_role.id}"

  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "elasticloadbalancing:*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "role_policy" {
  name = "role_policy"
  role = "${aws_iam_role.test_role.id}"

  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:CreateInstanceProfile",
                "iam:DeleteInstanceProfile",
                "iam:UpdateAssumeRolePolicy",
                "iam:List*",
                "iam:RemoveRoleFromInstanceProfile",
                "iam:DeletePolicy",
                "iam:CreateRole",
                "iam:DeleteRole",
                "iam:AttachRolePolicy",
                "iam:*Tag*",
                "iam:AddRoleToInstanceProfile",
                "iam:CreateAccessKey",
                "iam:CreatePolicy",
                "iam:PassRole",
                "iam:Get*",
                "iam:DetachRolePolicy",
                "iam:DeleteRolePolicy",
                "iam:PutRolePolicy",
                "iam:UpdateRole"
            ],
            "Resource": "*"

        }
    ]
}
EOF
}


resource "aws_iam_role_policy" "ecr_policy" {
  name = "ecr_policy"
  role = "${aws_iam_role.test_role.id}"

  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ecr:*",
            "Resource": "*"
        }
    ]
}
EOF
}


resource "aws_iam_role" "test_role" {
  name = "SantaPowerUser"

  assume_role_policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
EOF

  tags = {
    tag-key = "SantaPowerUser"
  }
}