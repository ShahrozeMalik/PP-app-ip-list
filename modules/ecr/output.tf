output "ecr_output" {

  value = {
    arn = aws_ecr_repository.my_repo.arn
    url = aws_ecr_repository.my_repo.repository_url
  }

}