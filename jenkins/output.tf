output "linux_ips" {
  value = ["${aws_instance.jenkins.*.public_ip}"]
}

# TODO Swarm not yet (1.13) supported on Windows
# output "windows_ips" {
#   value = ["${aws_instance.selenium-grid-windows.*.public_ip}"]
# }
# -- OR --
# output "windows_ips" {
#   value = ["${aws_instance.selenium-grid-windows.public_ip}"]
# }
