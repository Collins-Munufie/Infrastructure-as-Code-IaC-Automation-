provider "aws" {
  region = "us-west-2"
  profile = "Avinash"
  
}

#Create default VPC
resource "aws_default_vpc" "default_vpc" {
  
  tags = {
    Name = "default vpc"
  }
}
#Use data source to get all availability zones in region
data "aws_availability_zones" "available_zones" {}

#Create default Subnet in the first azailability zone
resource "aws_default_subnet" "subnet_az1" {
  availability_zone = data.aws_availability_zones.available_zones

}

#Create a default subnet in the second azailability zone
resource "aws_default_subnet" "subnet_az2" {
  availability_zone = data.aws_availability_zones.available_zones.names[1]
}

#Create Security group for the web server
resource "aws_security_group" "webserver_security_group" {
  name = "web server security group"
  description = "Security group for web server"
  vpc_id = aws_default_vpc.default_vpc.id
  
}