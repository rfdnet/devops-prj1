resource "aws_subnet" "private-us-west-2a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "us-west-2a"

  tags = {
    "Name"                            = "private-us-west-2a"
    "kubernetes.io/role/internal-elb" = "1"     //required by k8s to indetify where elb will be created
    "kubernetes.io/cluster/demo"      = "owned" //must spedicy here the eks cluster name, eg : demo
  }
}

resource "aws_subnet" "private-us-west-2b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "us-west-2b"

  tags = {
    "Name"                            = "private-us-west-2b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "public-us-west-2a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "public-us-west-2a"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}

resource "aws_subnet" "public-us-west-2b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "public-us-west-2b"
    "kubernetes.io/role/elb"     = "1" //public ELB on this subnet
    "kubernetes.io/cluster/demo" = "owned"
  }
}
