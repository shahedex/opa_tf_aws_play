variable "vpc_cidr" {
    description = "Select your vpc cidr value"
    type = string
    default = "10.10.0.0/16"
}

variable "region" {
    description = "Select your vpc region"
    type = string
    default = "us-east-1"
}

variable "nat_amis" {
    type = map
    default = {
        "us-east-1" = "ami-00a9d4a05375b2763"
    }
}

variable "web_amis" {
  type = map
  default = {
      "us-east-1" = "ami-09e67e426f25ce0d7"
  }
}

variable "web_instance_type" {
    type = string
    description = "Choose instance type for your web"
    default = "t2.micro"
}

variable "web_tags" {
    type = map
    description = "tags for your web instances"

    default = {
        "Name" = "Webserver"
    }
}

variable "web_ec2_count" {
    type = string
    description = "Choose number of ec2 instances for web"
    default = "2"
}
