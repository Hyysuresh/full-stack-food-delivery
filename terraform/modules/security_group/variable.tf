variable "vpc_id" {
    description = "The ID of the VPC where the security group will be created"
    type        = string   
}
variable "name" {
    description = "The name of the VPC where the security group will be created"
    type        = string   
}

variable "environment" {
    description = "The name of the environment (e.g., production, staging)"
    type        = string
}
