# This file assigns specific values to the variables defined in variables.tf.
# This keeps the main configuration files clean and allows for easy environment switching.

# --- AWS CONFIGURATION ---
aws_region = "ap-south-1"

# --- VPC CONFIGURATION ---
vpc_cidr           = "10.0.0.0/16"
availability_zones = ["ap-south-1a", "ap-south-1b"]

# --- EKS CLUSTER CONFIGURATION ---
cluster_name    = "devsecops-eks-cluster"
cluster_version = "1.27"

# --- NODE GROUP CONFIGURATION ---
instance_type     = "t3.medium"
node_min_size     = 1
node_max_size     = 3
node_desired_size = 2

# --- ACCESS CONFIGURATION ---
# Placeholder: This should be updated with the real IAM role ARN
jenkins_deploy_role_arn = "arn:aws:iam::012345678901:role/JenkinsDeployRole"
