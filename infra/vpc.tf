resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16" //CIDR BLOCK with 65536 hosts

  tags = {
    Name = "main"
    Env  = "my demo project"
  }
}
