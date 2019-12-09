
resource "aws_instance" "pt_node_module" {
  ami                    = "ami-0612808b4a0ca35a1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.sg_jenkins.id}"]
  # aws_security_group = "${aws_security_group.sg_jenkins.name}"
  key_name = "node-key"
  tags = {
    Name = "Jenkins Node_PT"
  }
}

resource "aws_security_group" "sg_jenkins" {
  name        = "sg3"
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
    from_port = 8080
    to_port   = 8080
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
  value = "${aws_instance.pt_node_module.id}"
}
