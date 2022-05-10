output "public_id" {
  value = aws_subnet.main_subnet_A_Public.id
}

output "private_id" {
  value = aws_subnet.main_subnet_A_Private.id
}

output "sg_id" { 
  value = aws_security_group.allow_nlb.id
}