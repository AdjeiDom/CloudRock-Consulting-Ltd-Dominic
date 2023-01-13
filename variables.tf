/* variable "aws_access_key" {
}

variable "aws_secret_key" {
} */

variable "region" {
    default = "eu-west-2"
    description = "AWS Region"
}

#Production VPC
variable "cidr_block" {
    default = "10.0.0.0/16"
    description = "VPC IPv4 cidr"
}

variable "Name" {
    default = "Prod-rock-VPC"
    description = "My VPC name"
}

/* public subnet 1*/
variable "public-sub1-cidr_block" {
    default = "10.0.1.0/24"
    description = "public-sub1 cidr"
}

variable "public-sub1-AZ" {
    default = "eu-west-2a"
    description = "public-sub1 availability_zone"
}

variable "pub-sub1-Name" {
    default = "Test-public-sub1"
    description = "My public sub1 name"
}

/* public subnet 2*/
variable "public-sub2-cidr_block" {
    default = "10.0.2.0/24"
    description = "public-sub2 cidr"
}

variable "public-sub2-AZ" {
    default = "eu-west-2b"
    description = "public-sub2 availability_zone"
}

variable "pub-sub2-Name" {
    default = "test-public-sub2"
    description = "My public sub2 name"
}

/* private subnet 1*/
variable "private-sub1-cidr_block" {
    default = "10.0.3.0/24"
    description = "private-sub1 cidr"
}

variable "private-sub1-AZ" {
    default = "eu-west-2a"
    description = "private-sub1 availability_zone"
}

variable "priv-sub1-Name" {
    default = "Test-priv-sub1"
    description = "My private sub1 name"
}

/* private subnet 2*/
variable "private-sub2-cidr_block" {
    default = "10.0.4.0/24"
    description = "private-sub2 cidr"
}

variable "private-sub2-AZ" {
    default = "eu-west-2b"
    description = "private-sub2 availability_zone"
}

variable "priv-sub2-Name" {
    default = "Test-priv-sub2"
    description = "My private sub2 name"
}

# public route table
variable "pub-route-table-Name" {
    default = "Test-pub-route-table"
    description = "My public route table name"
}

# private route table
variable "priv-route-table-Name" {
    default = "Test-priv-route-table"
    description = "My private route table name"
}

#Internet gateway to communicate with public route table
variable "igw-Name" {
    default = "Test-igw"
    description = "internet gateway name"
}

# Route igw to associate with public route table
variable "destin-cidr_block" {
    default = "0.0.0.0/0"
    description = "route destination cidr"
}

#provision elastic IP for public NAT Gateway
variable "eip-Name" {
    default = "Test-EIP"
    description = "elastic IP for public NAT gateway name"
}

# public NAT gateway for private route table/subnets
variable "NAT-Name" {
    default = "Test-Nat-gateway"
    description = "public NAT gateway name"
}

# Route NAT gateway association with private route table
variable "NAT-destin-cidr_block" {
    default = "0.0.0.0/0"
    description = "route destination cidr"
}

/* Security Group resource with 2 ingress and 1 egress rules */
variable "SecGroup-Name" {
    default = "Test-sec-group"
    description = "security group name"
}
variable "SecGroup-Description" {
    default = "Allow TLS inbound and outbound traffic"
    description = "description for security group"
}

#1st ingress rules
variable "ingress1-type" {
    default = "SSH"
    description = "description for inbound rule type"
}
variable "ingress1-protocol" {
    default = "tcp"
    description = "inbound rule type protocol"
}
variable "ingress1-cidr_block" {
    default = ["0.0.0.0/0"]
    description = "inbound rule type cidr block"
}

#2nd ingress rules
variable "ingress2-type" {
    default = "HTTP"
    description = "description for inbound rule type"
}
variable "ingress2-protocol" {
    default = "tcp"
    description = "inbound rule type protocol"
}
variable "ingress2-cidr_block" {
    default = ["0.0.0.0/0"]
    description = "inbound rule type cidr block"
}

#egress rules
variable "egress-protocol" {
    default = "-1"
    description = "outbound rule type protocol"
}
variable "egress-cidr_block" {
    default = ["0.0.0.0/0"]
    description = "outbound rule type cidr block"
}

variable "SecGroup-Tag" {
    default = "Test-sec-group"
    description = "security group tag"
}

#public key obtained from the private key is stored on the server
variable "pub-key-Name" {
    default = "Test-key"
    description = "aws key pair name"
}

#private key stored on local client server
variable "privkey-algorthm-type" {
    default = "RSA"
    description = "tls private key algorithm type"
}

#local .pem file in which to save private key on local server
variable "privkey-file-Name" {
    default = "Cloud-Test-key"
    description = ".pem file name"
}

/* EC2 server in public subnet with Ubuntu Free Tier */
variable "pubsub-ami" {
    default = "ami-0f540e9f488cfa27d"
    description = "ami for EC2 server free tier Ubuntu"
}
variable "instance-type-Name" {
    default = "t2.micro"
    description = "ami instance type for EC2 server free tier Ubuntu"
}

variable "cpu-credit-specs" {
    default = "unlimited"
    description = "ami cpu credit specification"
}
variable "instance-Name" {
    default = "Test-serve-1"
    description = "EC2 server name"
}


/* EC2 server in private subnet with Ubuntu Free Tier */
variable "privsub-ami" {
    default = "ami-0be590cb7a2969726"
    description = "ami for EC2 server free tier Ubuntu"
}
variable "priv-inst-type-Name" {
    default = "t2.micro"
    description = "ami instance type for EC2 server free tier Ubuntu"
}

variable "priv-cpu-specs" {
    default = "unlimited"
    description = "ami cpu credit specification"
}
variable "priv-instance-Name" {
    default = "Test-serve-2"
    description = "EC2 server name"
}