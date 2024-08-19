resource "aws_ecr_repository" "vagasasaservice_website_repo" {
  name = "vagasasaservice-website-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}