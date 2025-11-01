variable "subnet_id" {
  type = string
}

variable "sg_id" {
  type = string
}

resource "aws_instance" "ec2_spring_app" {
  ami = "ami-0493936afbe820b28"
  subnet_id = var.subnet_id
  security_groups = [var.sg_id]
  instance_type = "t2.micro"
  key_name = "devops_instances"
  tags = {
    Name = "spring_app"
  }
}
output "ec2_public_ip" {
  value = aws_instance.ec2_spring_app.public_ip
}