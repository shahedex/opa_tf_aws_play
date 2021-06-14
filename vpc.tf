resource "aws_vpc" "my_app" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"

    tags = {
      "Name" = "my_changed_vpc"
      "Environment" = terraform.workspace
    }
}
