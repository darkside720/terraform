#resource "aws_vpc" "devqa_vpc" {
#  cidr_block = "${var.cidr_block}"
#}

resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.devqa_vpc.id}"

  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      #cidr_blocks = ["${var.internal_ip["devqa_vpc"]}"]
      cidr_blocks = ["10.0.0.0/16"]
      description = "DEVQA VPC"
  }

  ingress {
      from_port = 5432
      to_port = 5432
      protocol = "tcp"
      #cidr_blocks = ["${var.internal_ip["devqa_vpc"]}"]
      cidr_blocks = ["10.0.0.0/16"]
      description = "DEVQA VPC"
  }
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
