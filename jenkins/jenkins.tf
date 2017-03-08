resource "aws_instance" "jenkins" {
  count = 1

  subnet_id = "${aws_subnet.subnet.id}"

  ami = "ami-c951f0df"
  instance_type = "t2.micro"

  key_name = "test-validation"

  associate_public_ip_address = true
  tags {
    "Name" = "jenkins"
  }

  connection {
    user = "core"
    private_key = "${file("~/workshop/ec2/test-validation.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "curl -sSL https://get.docker.com/ | sh",
      "sudo systemctl enable docker.service",
      "sudo systemctl start docker.service",
      "sudo usermod -aG docker core"
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
