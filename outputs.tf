output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "IDs of the public subnets"
  value       = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

output "private_subnet" {
  description = "ID of the private subnet"
  value       = aws_subnet.private.id
}

output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}
