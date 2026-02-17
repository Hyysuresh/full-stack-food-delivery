variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
}
variable "vpc_name" {
    description = "The name of the VPC"
    type        = string
}
variable "azs" {
    description = "A list of availability zones for the VPC"
    type        = list(string)
}
variable "private_subnets" {
    description = "A list of CIDR blocks for the private subnets"
    type        = list(string)
}
variable "public_subnets" {
    description = "A list of CIDR blocks for the public subnets"
    type        = list(string)
}
variable "intra_subnets" {
    description = "A list of CIDR blocks for the infrastructure subnets"
    type        = list(string)
}
variable "environment" {
    description = "The name of the environment (e.g., production, staging)"
    type        = string
}
