# AWS EC2 Linux Instance

resource "aws_instance" "test" {
  
  ami           = "ami-0c2d06d50ce30b442"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.lb_subnet[0].id
  
}