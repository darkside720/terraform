resource "aws_rds_cluster_instance" "cluster_instances" {
  identifier         = "${var.cluster_name}-instance"
  cluster_identifier = "${aws_rds_cluster.cluster.id}"
  instance_class     = "${var.instance_class}"
}

resource "aws_rds_cluster" "cluster" {
  cluster_identifier     = "${var.cluster_name}"
  database_name          = "sample_rds"
  master_username        = "${var.username}"
  master_password        = "${var.password}"
  vpc_security_group_ids = ["${aws_security_group.devqa_vpc}"]
  skip_final_snapshot    = true
}

resource "aws_security_group" "devqa_vpc" {
  name   = "aurora-security-group"

  ingress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "cluster_name" {
  default = "rds-sample-cluster"
} 
  
variable "instance_class" {
  default = "db.t2.small"
}

variable "username" {
  default = "master"
}

variable "password" {
  default = "password"
}
