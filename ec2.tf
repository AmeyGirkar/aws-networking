data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private.id

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/<SAME>/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Hello from Antigravity EC2 in Private Subnet</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "web-instance"
  }
}

resource "aws_lb_target_group_attachment" "main" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.web.id
  port             = 80
}
