output "ec2_instance" {
  value       = aws_instance.ec2_web_server
  description = "ec2 instance contents"
}
