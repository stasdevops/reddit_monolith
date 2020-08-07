
provider "aws" {
  region  = "eu-central-1"
  version = "3.0.0"
}

resource "aws_key_pair" "work2" {
  key_name   = "work2"
  public_key = file("work2.pem")
}

resource "aws_instance" "My_Reddit1" {
  ami                    = "ami-0d359437d1756caa8"
  instance_type          = "t2.micro"
  key_name               = "work2"
  vpc_security_group_ids = [aws_security_group.reddit.id]
  user_data              = file("user_data.sh")

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("work2.pem")
    host        = self.public_ip
  }

}

resource "aws_security_group" "reddit" {
  name        = "reddit"
  description = "9292"


  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "9292"
    from_port   = 9292
    to_port     = 9292
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
