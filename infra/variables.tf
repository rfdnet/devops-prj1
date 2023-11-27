variable "environment" {
  type        = string
  description = ""

}

variable "aws_region" {
  type        = string
  description = ""
}

// EKS Cluster NODE
variable "instance_type" {
  type        = list(string)
  description = "ec2 instace type for EKS Nodes"


}

//bastion host
variable "bastion_type" {
  description = "Bastion host ec2 instance type"
  type        = string
}

variable "ami_type" {
  type        = string
  description = "(optional) describe your variable"
}