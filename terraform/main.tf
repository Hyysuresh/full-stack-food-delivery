# Create IAM role for bastion
resource "aws_iam_role" "bastion" {
  name = "${local.tags.Name}-bastion-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach policies to bastion role
resource "aws_iam_role_policy_attachment" "bastion_eks" {
  role       = aws_iam_role.bastion.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Create instance profile for bastion
resource "aws_iam_instance_profile" "bastion" {
  name = "${local.tags.Name}-bastion-profile"
  role = aws_iam_role.bastion.name
}

module "bastion" {
  source                    = "./modules/bastion"
  subnet_id                 = module.vpc.public_subnets[0]
  bastion_security_group_id = module.security_group.bastion_security_group_id
  root_block_device         = local.root_block_device
  key_name                  = local.key_name
  environment               = local.environment
  instance_name             = local.instance_name
}
module "vpc" {
  source          = "./modules/vpc"
  vpc_name        = local.tags.Name
  vpc_cidr        = local.vpc_cidr
  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets
  intra_subnets   = local.intra_subnets
  environment     = local.environment

}
module "eks" {
  source                    = "./modules/eks"
  cluster_name              = local.cluster_name
  cluster_version           = local.cluster_version
  vpc_id                    = module.vpc.vpc_id
  subnet_ids                = module.vpc.public_subnets
  bastion_security_group_id = module.security_group.bastion_security_group_id
  environment               = local.environment
  eks_addon_versions = {
    coredns            = "v1.11.1-eksbuild.4"
    kube-proxy         = "v1.29.2-eksbuild.1"
    vpc-cni            = "v1.16.0-eksbuild.1"
    aws-ebs-csi-driver = "v1.29.0-eksbuild.1"
  }
  control_plane_subnet_ids = module.vpc.private_subnets
}
module "security_group" {
  source      = "./modules/security_group"
  environment = local.environment
  vpc_id      = module.vpc.vpc_id
  name        = local.name
}
