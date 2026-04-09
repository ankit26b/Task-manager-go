output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.task_manager.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.task_manager.public_ip
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.task_manager_sg.id
}
