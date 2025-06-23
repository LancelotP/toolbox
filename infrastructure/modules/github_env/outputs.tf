output "github_env_name" {
  value       = github_repository_environment.environment.environment
  description = "The GitHub environment name"
  sensitive   = true
}
