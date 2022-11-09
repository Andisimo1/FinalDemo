output "alb_hostname" {
  value = aws_alb.alb.dns_name
}
output "vpc_id" {
  value = aws_vpc.main.id
}
output "private_subnet_ids" {
  value = values(aws_subnet.private_subnet).*.id
}