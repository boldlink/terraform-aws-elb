output "id" {
  value       = aws_elb.main.id
  description = "The name of the ELB"
}

output "arn" {
  value       = aws_elb.main.arn
  description = "The ARN of the ELB"
}

output "name" {
  value       = aws_elb.main.name
  description = "The name of the ELB"
}

output "dns_name" {
  value       = aws_elb.main.dns_name
  description = "The DNS name of the ELB"
}

output "instances" {
  value       = aws_elb.main.instances
  description = "The list of instances in the ELB"
}

output "source_security_group" {
  value       = aws_elb.main.source_security_group
  description = "The name of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances. Use this for Classic or Default VPC only."
}

output "source_security_group_id" {
  value       = aws_elb.main.source_security_group_id
  description = "The ID of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances. Only available on ELBs launched in a VPC."
}

output "zone_id" {
  value       = aws_elb.main.zone_id
  description = "The canonical hosted zone ID of the ELB (to be used in a Route 53 Alias record)"
}

output "tags_all" {
  value       = aws_elb.main.tags_all
  description = "A map of tags assigned to the resource"
}
