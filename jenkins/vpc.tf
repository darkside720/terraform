# Create the VPC
# This also creates:
# 1. DHCP options set (dopt)
# 2. Route table (rtb)
# 3. Network ACL (acl)
# 4. Security group (sg)
resource "aws_vpc" "vpc" {
  cidr_block = "10.223.0.0/16"
  enable_dns_hostnames = true
  tags {
    "Name" = "jenkins"
  }
}

# Create an internet gateway (igw) for the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    "Name" = "jenkins"
  }
}

# Add a route to the route table, to send traffic to the gateway
resource "aws_route" "gw" {
  route_table_id = "${aws_vpc.vpc.default_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw.id}"
}
