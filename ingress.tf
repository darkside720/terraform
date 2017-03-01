# Fix the security group to allow inbound connections from the given public IP
variable "publiccidr" {
  description = "Public CIDR to give access to the created instances to."
  default = "0.0.0.0/0"
}

resource "aws_security_group_rule" "ingress" {
    type = "ingress"
    from_port = 0
    to_port = 65535
    protocol = "-1"
    cidr_blocks = ["${var.publiccidr}"]
    security_group_id = "${aws_vpc.vpc.default_security_group_id}"
}
