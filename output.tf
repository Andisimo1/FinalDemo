output "ecr_repository_url" {
  value = module.ecr.aws_ecr_repository_url
}
output "confirmation" {
  value = module.init-build.confirmation
}
output "alb_hostname" {
  value = module.cluster.alb_hostname
}