provider "aws" { 
region = "us-west-2"  
} 
resource "aws_vpc" "main_vpc" { 
cidr_block = "10.0.0.0/16" 
tags = { 
Name = "main_vpc" 
} 
} 

#EC2 instanec
resource "aws_instance" "web_server" {
  ami            = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type  = "t2.micro"
  subnet_id      = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.ec2_sg.name]
  

  tags = {
  Name = "web_server"
}

}

# RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private_subnet.id] # Use private subnet
  tags = {
    Name = "rds-subnet-group"
  }
}

# RDS Database Instance
resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"

  db_name = "my_database"
  username             = "admin"
  password             = "password"

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id] # Use .id
  skip_final_snapshot  = true

  tags = {
    Name = "rds_instance"
  }
}
