# Terraform Variables Definitions: variables.tf
# Defines all input variables for the EKS module.

# --- AWS CONFIGURATION ---
variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
}

# --- VPC CONFIGURATION ---
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "A list of availability zones to use for subnets."
  type        = list(string)
}

# --- EKS CLUSTER CONFIGURATION ---
variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
}

# --- NODE GROUP CONFIGURATION ---
variable "instance_type" {
  description = "Instance type for the EKS worker nodes (Managed Node Group)."
  type        = string
}

variable "node_min_size" {
  description = "Minimum size of the EKS worker node group."
  type        = number
}

variable "node_max_size" {
  description = "Maximum size of the EKS worker node group."
  type        = number
}

variable "node_desired_size" {
  description = "Desired capacity of the EKS worker node group."
  type        = number
}

# --- ACCESS CONFIGURATION ---
variable "jenkins_deploy_role_arn" {
  description = "ARN of the IAM role Jenkins uses for deployment (system:masters access)."
  type        = string
}
