
resource "aws_instance" "pt_master_module" {
  ami                    =  "ami-0acff51c40957b3c4"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.sg_jenkins.id}"]
  # aws_security_group = "${aws_security_group.sg_jenkins.name}"
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
  key_name = "master-key"
  tags = {
    Name = "Jenkins Master_Santa"
  }
}

resource "aws_security_group" "sg_jenkins" {
  name        = "sg2"
  description = "Allows all traffic"

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

resource "aws_iam_instance_profile" "test_profile" {
  name = "santa_profile"
  role = "ShellPowerUser"
}
