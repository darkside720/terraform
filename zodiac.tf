resource "aws_instance" "zodiac-grid-linux" {
  count = 2

  subnet_id = "${aws_subnet.subnet.id}"

  ami = "ami-afe438b9"
  instance_type = "t2.micro"

  key_name = "test-validation"

  associate_public_ip_address = true
  tags {
    "Name" = "zodiac-grid-linux"
  }

  connection {
    user = "ec2-user"
    private_key = "${file("~/workshop/ec2/test-validation.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "curl -sSL https://get.docker.com/ | sh",
      "sudo systemctl enable docker.service",
      "sudo systemctl start docker.service",
      "sudo usermod -aG docker ec2-user"
    ]
  }
}

# TODO Swarm not yet (1.13) supported on Windows
# resource "aws_instance" "selenium-grid-windows" {
#   subnet_id = "${aws_subnet.subnet.id}"

#   ami = "ami-e7b755f1"

#   instance_type = "t2.micro"

#   associate_public_ip_address = true
#   tags {
#     "Name" = "selenium-grid-windows"
#   }

#   user_data = <<EOF
# <script>
#   winrm quickconfig -q & winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"} & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
# </script>
# <powershell>
#   netsh advfirewall set allprofiles state off
#   $admin = [adsi]("WinNT://./administrator, user")
#   $admin.psbase.invoke("SetPassword", "Foo*Bar")
# </powershell>
# EOF
# }
