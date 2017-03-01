# Create the subnet in the vpc
resource "aws_subnet" "subnet" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.223.1.0/24"
  tags {
    "Name" = "zodiac-grid"
  }
}
