# Generate SSH Key Pair
resource "tls_private_key" "bastion" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save private key to file with secure permissions
resource "local_file" "bastion_private_key" {
  content         = tls_private_key.bastion.private_key_pem
  filename        = "${path.module}/keys/bastion1_key.pem"
  file_permission = "0400"
}

# Save public key to file in OpenSSH format
resource "local_file" "bastion_public_key" {
  content         = tls_private_key.bastion.public_key_openssh
  filename        = "${path.module}/keys/bastion1_key.pub"
  file_permission = "0644"
}

# Create AWS Key Pair with OpenSSH format
resource "aws_key_pair" "bastion" {
  key_name   = var.key_name
  public_key = tls_private_key.bastion.public_key_openssh
}


# Fetch the latest Ubuntu 22.04 LTS AMI for eu-north-1 region
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.small"
  key_name      = aws_key_pair.bastion.key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.bastion_security_group_id]
  root_block_device {
    volume_size = var.root_block_device.volume_size
    volume_type = "gp3"
  }
  tags = {
    Name = var.instance_name
    environment = var.environment
  }
}