locals {
  name        = "food-delivery01"
  environment = "production"

  # bastion configuration
  root_block_device = {
    volume_size = 8
  }
  key_name      = "food-delivery-key01"
  instance_name = "food-delivery-bastion"
  tags = {
    Name = "food-delivery01"
  }



  # VPC Configuration
  vpc_cidr        = "10.0.0.0/16"
  vpc_name        = "food-delivery"
  azs             = ["eu-north-1a", "eu-north-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  intra_subnets   = ["10.0.5.0/24", "10.0.6.0/24"]

  # eks configuration
  cluster_name    = "food-delivery01"
  cluster_version = "1.33"
}