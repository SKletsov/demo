output "repository" {
  value = module.ecr-go.repository
}

output "private_id" {
  value = module.vpc.private_id
}

output "public_id" {
  value = module.vpc.public_id
}