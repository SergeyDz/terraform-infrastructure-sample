output "ip" {
  value = aws_instance.vm.private_ip
}

output "private_key" {
  value     = tls_private_key.vm.private_key_pem
  sensitive = true
}