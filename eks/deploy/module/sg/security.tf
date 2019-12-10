resource "aws_security_group" "santa-sg-controlpanel-eks"{
  name = "santa-sg-controlpanel-eks"
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 1025
    to_port         = 65535
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    #prefix_list_ids = ["pl-12c4e678"]
  }
  egress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    #prefix_list_ids = ["pl-12c4e678"]
  }
  tags = {
     Name  = "santa-sg-controlpanel-eks"
     Owner = "santa"
     Environment = "Non-Production"
   }
}
resource "aws_security_group" "santa-sg-workernode-eks"{
  name = "santa-sg-workernode-eks"
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["185.46.212.0/22"]
  }
  egress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    #prefix_list_ids = ["pl-12c4e678"]
  }
  tags = {
     Name  = "santa-sg-workernode-eks"
     Owner = "santa"
     Environment = "Non-Production"
   }
}

resource "aws_security_group_rule" "ingress_rule_worker" {
  type            = "ingress"
  from_port       = 1025
  to_port         = 65535
  protocol        = "tcp"
  # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
  cidr_blocks = ["0.0.0.0/0"]# add a CIDR block here

  security_group_id = aws_security_group.santa-sg-workernode-eks.id
  depends_on = [aws_security_group.santa-sg-workernode-eks]
}