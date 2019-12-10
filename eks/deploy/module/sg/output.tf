output "security_controlpanel_eks" {
  description="the security group name"
  value=aws_security_group.santa-sg-controlpanel-eks.name
}

output "security_workergroup_name" {
  description="the security group name"
  value=aws_security_group.santa-sg-workernode-eks.name
}
