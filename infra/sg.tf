resource "aws_security_group" "sg-bastion-ingress" {

  name        = "allow-bastion-ingress"
  description = "Allow ssh connections on bastion"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "sg-bastion-ingress"
  }

  ingress {
    description = "allow ssh - managed by Terraform"
    cidr_blocks = ["179.98.136.91/32"] //needs to improve this!
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"


  }

  ingress {
    description = "allow icmp - managed by Terraform "
    cidr_blocks = ["0.0.0.0/0"] //need to improve this!
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"


  }

  // Terraform removes the default rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]


  }




}