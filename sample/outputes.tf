output "password" {
  value = random_password.iac-poc-tf.result
  sensitive = true
}

output "external_ip" {
   value = data.azurerm_public_ip.iac-poc-tf.ip_address
}