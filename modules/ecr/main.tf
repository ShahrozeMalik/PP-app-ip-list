########## ECR ###########
resource "aws_ecr_repository" "my_repo" {
  name                 = "eksrepo"

  image_scanning_configuration {
    scan_on_push = true
  }
}