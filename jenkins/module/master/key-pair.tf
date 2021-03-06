# master key pair defined for doing ssh onto Jenkins server
resource "aws_key_pair" "master" {
  key_name   = "master-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJ1w/fmc9lte4+XFzl8xRNpMrg5ngLuZuW++Y+5zzJOazFDVWGpDgThD9cF8wThoEO9+L3DIYwylzLJveq8Ct/4ijiTaHISnvn5zsLMLh9mWgP8coNmpSuYQkxtnRTV3GonzLbT6fGwuFRDeJucgrowkFeKl7jfJtMvswqaIgD3M+h4ZwpcnYSD+fxCogwRcEnz1gZQcSWjS+sA1ByJNrj3jkACVGUcmXl4GIxN1yTwXHnfIn8WNPUCEy8puDDKrId2De7fVz0mv6aUrbyj0boTn3OWeCdSXngCVnBlhondHd7G8Inzzkr12d/v+GZRm/Rz8W7kou/1MRZLUHmRRUZ"
}