output "instance_ips" {
  value = join(",", aws_instance.wordpressinstance.*.public_ip)
}

output "instance_dns" {
  value = join(",", aws_instance.wordpressinstance.*.public_dns)
}

