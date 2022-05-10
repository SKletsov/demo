resource "aws_ecr_repository" "ecr" {
  name                 = var.name
  image_tag_mutability = var.mutability
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}
