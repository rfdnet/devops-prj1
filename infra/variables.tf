variable "aws_region" {
  type        = string
  description = ""
  default     = "us-west-2"
}

// EKS Cluster NODE
variable "instance_type" {
  type        = list(string)
  description = "ec2 instace type for EKS Nodes"
  default     = ["t3.small"]

}

//bastion host
variable "bastion_type" {
  description = "Bastion host ec2 instance type"
  type        = string
  default     = "t2.micro"
  //default = "t3.small"
}

variable "ami_type" {
  type        = string
  description = "(optional) describe your variable"
  default     = "ami-0cd5f46e93e42a496"
}