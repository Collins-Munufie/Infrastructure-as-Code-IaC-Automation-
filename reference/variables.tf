variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "three-tier-app"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_az1_cidr" {
  description = "CIDR block for public subnet AZ1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_az2_cidr" {
  description = "CIDR block for public subnet AZ2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_app_subnet_az1_cidr" {
  description = "CIDR block for private app subnet AZ1"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_app_subnet_az2_cidr" {
  description = "CIDR block for private app subnet AZ2"
  type        = string
  default     = "10.0.4.0/24"
}

variable "private_data_subnet_az1_cidr" {
  description = "CIDR block for private data subnet AZ1"
  type        = string
  default     = "10.0.5.0/24"
}

variable "private_data_subnet_az2_cidr" {
  description = "CIDR block for private data subnet AZ2"
  type        = string
  default     = "10.0.6.0/24"
}