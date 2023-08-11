resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "MyVPC"
  }
}
/*
resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.aws_subnet_cidr

  tags = {
    Name = "Subnet1"
  }
}*/

resource "aws_subnet" "subnet" {
  count = length(var.subnets)

  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnets[count.index]

  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]

  tags = {
    Name = "Subnet ${count.index + 1}"
  }
}



resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyIGW"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.my_vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

resource "aws_security_group" "my_security_group" {
  name_prefix = "my_security_group"
  vpc_id      = aws_vpc.my_vpc.id

  # Allow SSH from anywhere
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow ICMP (ping) from anywhere
  ingress {
    from_port   = -1  # -1 indicates all ports
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      aws_subnet.subnet[0].cidr_block,
      aws_subnet.subnet[1].cidr_block,
      aws_subnet.subnet[2].cidr_block,
      ]
    }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
      }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "master_eip" {
  count = var.aws_master_count
}

resource "aws_eip_association" "vm_eip_assoc_master" {
  count = var.aws_master_count

  instance_id = aws_instance.master_instance[count.index].id
  allocation_id = aws_eip.master_eip[count.index].id
}

resource "aws_eip" "worker_eip" {
  count = var.aws_worker_count
}

resource "aws_eip_association" "vm_eip_assoc_worker" {
  count = var.aws_worker_count

  instance_id = aws_instance.worker_instances[count.index].id
  allocation_id = aws_eip.worker_eip[count.index].id
}
