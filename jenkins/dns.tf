# create a DNS zone in the DEV VPC (where the clients are)
resource "aws_route53_zone" "zone" {
  name = "jenkins"
  vpc_id = "vpc-c55198a0"
}

# create the DNS record for the grid
resource "aws_route53_record" "hostname" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  name = "jenkins"
  type = "A"
  ttl = "300"
  records = ["${aws_instance.jenkins.0.public_ip}"]
}
