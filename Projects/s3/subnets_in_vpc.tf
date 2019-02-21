#Changing The Order and CHecking whether it matters
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "NJ_HOME_VPC"
  }
}

# data "aws_vpc" "my_vpc" {
#   id = "vpc-0f908d460573e6f37"
# }

resource "aws_subnet" "Public_Subnet" {
  count                   = 3
  vpc_id                  = "${aws_vpc.my_vpc.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.my_vpc.cidr_block,8,count.index)}"
  availability_zone       = "${data.aws_availability_zones.all.names[count.index]}"
  map_public_ip_on_launch = "true"

  tags = {
    Name        = "Public_Subnet-${count.index+1}"
    Description = "Created by Terrafrom "
  }
}

resource "aws_internet_gateway" "my_pub_igw" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  tags = {
    Name        = "IGW Route Out"
    Description = "NJ IGW By Terraform"
  }
}

resource "aws_route_table" "route_out" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.my_pub_igw.id}"
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = "${aws_internet_gateway.my_pub_igw.id}"
  }

  tags = {
    Name = "Public Route Out"
  }
}


resource "aws_route_table_association" "route_ass" {
  count          = "${length(aws_subnet.Public_Subnet.*.id)>0?length(aws_subnet.Public_Subnet.*.id):0}"
#  count = "${length(data.aws_subnet_ids.Public.ids)}"
  route_table_id = "${aws_route_table.route_out.id}"
  subnet_id      = "${aws_subnet.Public_Subnet.*.id[count.index]}"

  depends_on = ["aws_subnet.Public_Subnet", "aws_vpc.my_vpc", "aws_route_table.route_out"]
}



