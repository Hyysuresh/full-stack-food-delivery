variable "subnet_id" {
    description = "The ID of the subnet where the bastion host will be deployed"
    type        = string
}
variable "bastion_security_group_id" {
    description = "The security group for the bastion host"
    type        = string
}

variable "root_block_device" {
    description = "Configuration for the root block device of the bastion host"
    type = object({
        volume_size = number
    })
}
variable "key_name" {
    description = "The name of the AWS Key Pair to use for SSH access"
    type        = string
}
variable "environment" {
    description = "the name of environmnet"
    type = string
}
variable "instance_name" {
    description = "the name of the instance"
    type = string
}

