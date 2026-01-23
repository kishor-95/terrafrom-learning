output "instance_hostname" {
     value = aws_instance.app_server.private_dns
}

output "public_ip"{
    value = aws_instance.app_server.public_ip
}

output "vpc_details" {
    value = aws_instance.app_server.vpc_security_group_ids
}
