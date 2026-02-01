#Create a security Group for the Application load Balancer
#Terraform aws create security group
resource "aws_security_group" "alb-security-group" {
  name        = "ALB Security Group"
  description = "Enable HTTP/HTTPS access on port 80/443"
  vpc_id      = aws_vpc.main_vpc.id
  
  ingress {
    description = "HTTP Acces"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    description = "HTTPS access"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]

  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = {
    Name = "ALB security Group"
  }



}
#Create Security Group for Bation Host
resource "aws_security_group" "ssh-security-group" {
  name         = "SSH access"
  description  = "Enable SSH access on port 22"
  vpc_id       = "aws_vpc.main_vpc.id"

  ingress {
    description = "SSH access"
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["${var.ssh-location}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SSH Security Group"
  }
  
}
#Create Security Group fo the Web server
resource "aws_security_group" "web-server-security-group" {
  name = "Web server security group"
  description = "Enable HTTP/HTTPS access on port 80/43 via ALB and SSH on porty 22 "
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    description ="HTTP access"
    from_port   =80
    to_port  =80
    protocol   ="tcp"
    security_groups = ["${aws_security_group.alb-security-group.id}"]
  }

  # ingress {
  #   description = "HTTPS access"
  #   from_port = 443
  #   to_port = 443
  #   protocol = "tcp"
  #   security_groups = [ "${aws_security_group.alb-security-group.id}" ]

  # }

  # ingress {
  #   description = "SSH access"
  #   from_port = 22
  #   to_port = 22
  #   protocol = "tcp"
  #   security_groups = [ "${aws_security_group.ssh-security-group.id}" ]

  # }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web Server Security Group"
  }
  
}

#Create Security Group for the Databse
resource "aws_security_group" "Databse-security-group" {
  name = "Database Security Group"
  description = "Enable MYSQL Aurora access on port 3306"
  vpc_id = aws_vpc.main_vpc.id

ingress {
  description = "MYSQL/Aurora"
  from_port = 3306
  to_port =  3306
  protocol = "tcp"
  security_groups = ["${aws_security_group.web-server-security-group.id}"]
} 

egress {
  from_port = 0
  to_port = 0
  protocol = 0
  cidr_blocks = ["0.0.0.0/0"]
}

tags = {
Name = "Database Security Group"
}
}

#EC2 security Group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL access from EC2"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

