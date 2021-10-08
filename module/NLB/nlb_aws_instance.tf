# AWS EC2 Linux Instance

resource "aws_instance" "test" {
  
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.lb_subnet[0].id
  
}
