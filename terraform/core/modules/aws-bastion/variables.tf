variable "name" {
  description = "Name of the private SSM-managed EC2 host and its supporting resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC in which to create the host security group."
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet with outbound access to SSM through NAT or VPC endpoints."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the SSM host."
  type        = string
  default     = "t3.micro"
}
