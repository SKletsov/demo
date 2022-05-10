resource "aws_security_group" "allow_nlb" {
  name        = "nlb"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "k8s nodePort"
   from_port         = 0
  to_port           = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_nlb"
  }
}