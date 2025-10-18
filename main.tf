# This file is the primary configuration, referencing variables and calling modules.

# --- PROVIDER CONFIGURATION ---
provider "aws" {
  region = var.aws_region
}

# --- VPC MODULE ---
# Provision a new VPC using input variables defined in variables.tf
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.1.0"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  # Uses variables for AZs, subnets are derived from the main VPC CIDR for simplicity
  azs             = var.availability_zones
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  enable_dns_hostnames   = true
  enable_dns_support     = true

  tags = {
    Name = "${var.cluster_name}-VPC"
  }
}

# --- EKS CLUSTER MODULE ---
# Provision the Amazon EKS cluster control plane and a managed node group.
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.24.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  # Enables IAM roles for Service Accounts (IRSA)
  enable_irsa = true

  eks_managed_node_groups = {
    default = {
      instance_types = [var.instance_type]
      min_size       = var.node_min_size
      max_size       = var.node_max_size
      desired_size   = var.node_desired_size

      # Essential tag for EKS Cluster Auto-Scaler functionality
      tags = {
        "k8s.io/cluster-autoscaler/enabled" = "true"
      }
    }
  }

  # ACCESS CONFIGURATION: Allows Jenkins to authenticate as a cluster administrator
  manage_aws_auth_configmap = true
  aws_auth_roles = [
    {
      rolearn  = var.jenkins_deploy_role_arn
      username = "jenkins-deploy-user"
      groups   = ["system:masters"]
    },
  ]

  # EKS Tags for Cost Allocation and Inventory
  tags = {
    Environment = "DevSecOps"
    Project     = "CICD-Pipeline"
  }
}
