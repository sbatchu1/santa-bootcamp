resource "aws_ecr_repository" "santa-ecr" {
  name                 = "santa"
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}