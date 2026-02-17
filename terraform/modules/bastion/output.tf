output "bastion_public_ip" {
  description = "The public IP address of the bastion EC2 instance"
  value       = aws_instance.bastion.public_ip
}
output "bastion_security_group_id" {
  description = "The ID of the bastion EC2 instance"
  value       = aws_instance.bastion.id
}
output "bastion_public_dns" {
  description = "The public DNS of the bastion EC2 instance"
  value       = aws_instance.bastion.public_dns
}
output "bastion_private_key_path" {
  description = "The file path to the private key for the bastion host"
  value       = local_file.bastion_private_key.filename
}
output "bastion_public_key_path" {
  description = "The file path to the public key for the bastion host"
  value       = local_file.bastion_public_key.filename
}
output "bastion_key_path" {
  description = "Path to the bastion SSH key"
  value       = "${path.module}/keys/bastion_key.pem"
}
output "bastion_key_name" {
  description = "Name of the SSH key pair"
  value       = aws_key_pair.bastion.key_name
}