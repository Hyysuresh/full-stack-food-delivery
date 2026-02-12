output "bastion_security_group_id" {
  description = "The ID of the security group for the bastion host"
  value       = aws_security_group.bastion_sg.id
}
