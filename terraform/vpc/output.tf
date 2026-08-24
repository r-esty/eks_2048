output "public_1_id" {
  value = aws_subnet.public_1.id
}

output "public_2_id" {
    
    value = aws_subnet.public_2.id
  
}

output "private_1_id" {

    value = aws_subnet.private_1.id
  
}

output "private_2_id" {

    value = aws_subnet.private_2.id
  
}

output "id" {
  value = aws_vpc.main.id
}
