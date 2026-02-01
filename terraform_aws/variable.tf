variable "ssh-location" {
  default = "0.0.0.0/0"
  description = "IP Address that can ssh into EC@ instance"
  type = string
}