# Defines the key values outputted after a successful deployment.
# These outputs are crucial for connecting the Jenkins pipeline to the cluster.

# --- EKS CONNECTION DETAILS ---
output "cluster_endpoint" {
  description = "Endpoint URL for the EKS control plane API server."
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "The name of the provisioned EKS cluster."
  value       = module.eks.cluster_name
}

output "kubeconfig_command" {
  description = "Command to update your local kubeconfig file to connect to the cluster."
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.aws_region}"
}

# --- NETWORKING DETAILS ---
output "vpc_id" {
  description = "The ID of the VPC created for the cluster."
  value       = module.vpc.vpc_id
}
