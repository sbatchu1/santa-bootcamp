output "security_control_group_name" {
  description="the security control group name"
  value=module.santa-sg-eks.security_controlpanel_eks
}

output "security_worker_group_name" {
  description="the security worker group name"
  value=module.santa-sg-eks.security_workergroup_name
}
