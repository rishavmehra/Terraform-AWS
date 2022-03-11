resource "aws_subnet" "myappsubnet-subnet-1" {
  vpc_id = var.vpc_ip
  cidr_block = var.subnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name = "${var.env_prefix}-subnet-1"
  }
}

resource "aws_internet_gateway" "myapp-igw" {
  vpc_id = var.vpc_id
  tags = {
    Name:  "${var.env_prefix}-igw"
  }
}


resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = var.default_route_table_id
  route {
    cidr_block ="0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-igw.id
  }
  tags = {
    Name:  "${var.env_prefix}-rtb"
  }
}

/*
resource "aws_route_table" "myapp-route-table" {
  vpc_id = aws_vpc.myapp-vpc.id
  route {
    cidr_block ="0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-igw.id
  }
  tags = {
    Name:  "${var.env_prefix}-rtb"
  }
}
*/

/*
resource "aws_route_table_association" "a-rtb-subnet" {
  subnet_id = aws_subnet.myappsubnet-subnet-1.id
  route_table_id = aws_route_table.myapp-route-table.id
}
// this configuration for when you create your own Route table not using default one  
*/


/*
resource "aws_security_group" "myapp-sg" {
  name = "myapp-sg"
  vpc_id = aws_vpc.myapp-vpc.id

  ingress {
    from_port = 22 
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
  tags = {
    Name:  "${var.env_prefix}-sg"
  }
}*/
