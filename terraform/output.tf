# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = local.vpc_cidr
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

# EKS Outputs
output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = local.cluster_name
}

# Bastion Outputs
output "bastion_public_ip" {
  description = "Public IP address of the bastion host"
  value       = module.bastion.bastion_public_ip
}

output "bastion_security_group_id" {
  description = "ID of the bastion security group"
  value       = module.security_group.bastion_security_group_id
}

# Access Information
output "access_information" {
  description = "Access information for the infrastructure"
  value = {
    bastion = {
      public_ip = module.bastion.bastion_public_ip
      ssh_command = "ssh -i ${module.bastion.bastion_key_path} ubuntu@${module.bastion.bastion_public_ip}"
    }
    eks = {
      cluster_name = local.cluster_name
      endpoint = module.eks.cluster_endpoint

    }
    vpc = {
      id = module.vpc.vpc_id
      cidr = local.vpc_cidr
      public_subnets = module.vpc.public_subnets
      private_subnets = module.vpc.private_subnets
    }
  }
}