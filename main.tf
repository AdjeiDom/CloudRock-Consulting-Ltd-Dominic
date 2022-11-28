#Production VPC
resource "aws_vpc" "Prod-rock-VPC" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  
  tags = {
    Name = var.Name
  }
}

/* public subnet 1*/
resource "aws_subnet" "Test-public-sub1" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.public-sub1-cidr_block
  availability_zone = var.public-sub1-AZ

  tags = {
    Name = var.pub-sub1-Name
  }
}

/* public subnet 2*/
resource "aws_subnet" "test-public-sub2" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.public-sub2-cidr_block
  availability_zone = var.public-sub2-AZ

  tags = {
    Name = var.pub-sub2-Name
  }
}

/* private subnet 1*/
resource "aws_subnet" "Test-priv-sub1" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.private-sub1-cidr_block
  availability_zone = var.private-sub1-AZ

  tags = {
    Name = var.priv-sub1-Name
  }
}

/* private subnet 2*/
resource "aws_subnet" "Test-priv-sub2" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.private-sub2-cidr_block
  availability_zone = var.private-sub2-AZ

  tags = {
    Name = var.priv-sub2-Name
  }
}

# public route table
resource "aws_route_table" "Test-pub-route-table" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = var.pub-route-table-Name
  }
}

# private route table
resource "aws_route_table" "Test-priv-route-table" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = var.priv-route-table-Name
  }
}

#Public route table association with subnets (public)
resource "aws_route_table_association" "public-route-association-1" {
  subnet_id      = aws_subnet.Test-public-sub1.id
  route_table_id = aws_route_table.Test-pub-route-table.id
}

resource "aws_route_table_association" "public-route-association-2" {
  subnet_id      = aws_subnet.test-public-sub2.id
  route_table_id = aws_route_table.Test-pub-route-table.id
}


#Private route table association with subnets (private)
resource "aws_route_table_association" "private-route-association-1" {
  subnet_id      = aws_subnet.Test-priv-sub1.id
  route_table_id = aws_route_table.Test-priv-route-table.id
}

resource "aws_route_table_association" "private-route-association-2" {
  subnet_id      = aws_subnet.Test-priv-sub2.id
  route_table_id = aws_route_table.Test-priv-route-table.id
}

#Internet gateway to communicate with public route table
resource "aws_internet_gateway" "Test-igw" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = var.igw-Name
  }
}

# Route internet gateway to associate with public route table
resource "aws_route" "Test-igw-association" {
  route_table_id            = aws_route_table.Test-pub-route-table.id
  destination_cidr_block    = var.destin-cidr_block
  gateway_id                = aws_internet_gateway.Test-igw.id
}



#provision elastic IP for public NAT Gateway 
resource "aws_eip" "Test-EIP" {
    vpc = true
    depends_on                = [aws_internet_gateway.Test-igw]
  tags = {
    Name = var.eip-Name
  }
}

# public NAT gateway for private route table/subnets
resource "aws_nat_gateway" "Test-Nat-gateway" {
  allocation_id = aws_eip.Test-EIP.id
  subnet_id = aws_subnet.Test-priv-sub1.id 

  tags = {
    Name = var.NAT-Name
  }

  /* # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.example] */
}

# NAT gateway to associate with private route table
resource "aws_route" "test-Nat-association" {
  route_table_id            = aws_route_table.Test-priv-route-table.id
  destination_cidr_block    = var.NAT-destin-cidr_block
  gateway_id                = aws_nat_gateway.Test-Nat-gateway.id
}


/* Security Group resource with 2 ingress and 1 egress rules */
resource "aws_security_group" "Test-sec-group" {
  name        = var.SecGroup-Name
  description = var.SecGroup-Description
  vpc_id      = "${aws_vpc.Prod-rock-VPC.id}"

  ingress {
    description      = var.ingress1-type
    from_port        = 22
    to_port          = 22
    protocol         = var.ingress1-protocol
    cidr_blocks      = var.ingress1-cidr_block
    ipv6_cidr_blocks = ["::/0"]
  }

ingress {
    description      = var.ingress2-type
    from_port        = 80
    to_port          = 80
    protocol         = var.ingress2-protocol
    cidr_blocks      = var.ingress2-cidr_block
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = var.egress-protocol
    cidr_blocks      = var.egress-cidr_block
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.SecGroup-Tag
  }
}


#public key obtained from the private key is stored on the server
resource "aws_key_pair" "Test-key" {
  key_name   = var.pub-key-Name
  public_key =  tls_private_key.Test-private-key.public_key_openssh
}

#private key stored on local client server
# RSA key of size 4096 bits
resource "tls_private_key" "Test-private-key" {
  algorithm = var.privkey-algorthm-type
  rsa_bits  = 4096
}

#local file in which to save private key on local server
resource "local_file" "Cloudrock-Test-key" {
    content  = tls_private_key.Test-private-key.private_key_pem
    filename = var.privkey-file-Name
}



/* EC2 server in public subnet with Ubuntu Free Tier */
resource "aws_instance" "Test-serve-1" {
  ami           = var.pubsub-ami # eu-west-2, Ubuntu Free Tier
  instance_type = var.instance-type-Name
  vpc_security_group_ids = ["${aws_security_group.Test-sec-group.id}"]
  key_name = "${aws_key_pair.Test-key.id}"
  subnet_id     = "${aws_subnet.Test-public-sub1.id}"
  associate_public_ip_address = true

  credit_specification {
    cpu_credits = var.cpu-credit-specs 
  }

   tags = {
    Name = var.instance-Name
  }
}



/* EC2 server in private subnet with Ubuntu Free Tier */
resource "aws_instance" "Test-serve-2" {
  ami           = var.privsub-ami # eu-west-2, Ubuntu Free Tier
  instance_type = var.priv-inst-type-Name
  vpc_security_group_ids = ["${aws_security_group.Test-sec-group.id}"]
  key_name = "${aws_key_pair.Test-key.id}"
  subnet_id     = "${aws_subnet.Test-priv-sub2.id}"
  
  credit_specification {
    cpu_credits = var.priv-cpu-specs 
  }

   tags = {
    Name = var.priv-instance-Name
  }
}
