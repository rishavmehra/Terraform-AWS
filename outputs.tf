
output "ec2_public_ip" {
  value = module.myapp-serve.instance.public_key
}