locals {
  pri_sub_start = length(slice(local.az_names, 0, 2))
  pri_sub_ids = aws_subnet.private.*.id
}

resource "aws_subnet" "private" {
    count = local.pri_sub_start
    vpc_id = aws_vpc.my_app.id
    cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + length(local.az_names))
    availability_zone = local.az_names[count.index]

    tags = {
      "Name" = "private-subnet-${count.index + 1}"
    }
}

resource "aws_instance" "nat" {
    ami = var.nat_amis[var.region]
    instance_type = "t2.micro"
    subnet_id = local.pub_sub_ids[0]
    source_dest_check = false
    vpc_security_group_ids = [aws_security_group.nat_sg.id]

    tags = {
      "Name" = "my_app_nat"
    }
}

resource "aws_route_table" "privatert" {
    vpc_id = aws_vpc.my_app.id

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = aws_instance.nat.id
    }

    tags = {
      "Name" = "my_app_private"
    }
}

resource "aws_route_table_association" "pri_rtb_assoc" {
    count = local.pri_sub_start
    subnet_id = local.pri_sub_ids[count.index]
    route_table_id = aws_route_table.privatert.id
}

resource "aws_security_group" "nat_sg" {
    name = "nat_sg"
    description = "allow traffic for private subnets"
    vpc_id = aws_vpc.my_app.id

    egress {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 0
      protocol = "-1"
      to_port = 0
    }
}
