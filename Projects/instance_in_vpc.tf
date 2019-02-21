data "aws_subnet_ids" "Public" {
  vpc_id = "vpc-0f908d460573e6f37"

  tags = {
    Name = "Public_Subnet"
  }
}

resource "aws_instance" "Public_Ec2" {
  count                = 3
  ami                  = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.mykey.key_name}"
  iam_instance_profile = "S3-Admin-Access"
  subnet_id            = "${element(data.aws_subnet_ids.Public.ids, count.index)}"

  user_data = "${file("scripts/install.sh")}"

  tags = {
    Name        = "Terrafrom Created ${count.index + 1}"
    Description = ""
  }

  # security_groups = ["sg-04baec5d0ded316e8"]
  vpc_security_group_ids = ["sg-04baec5d0ded316e8"]
}

data "aws_subnet_ids" "Private_Subnet" {
  vpc_id = "vpc-0f908d460573e6f37"

  tags = {
    Name = "Private_Subnet"
  }
}

data "aws_subnet_ids" "example" {
  vpc_id = "vpc-0f908d460573e6f37"

  tags = {
    Name = "Public_Subnet"
  }
}

data "aws_subnet" "example" {
  count = "${length(data.aws_subnet_ids.example.ids)}"
  id    = "${data.aws_subnet_ids.example.ids[count.index]}"
}

output "subnet_cidr_blocks" {
  value = ["${data.aws_subnet.example.*.cidr_block}"]
}

output "CIDR BLOCKS" {
  value = ["${data.aws_subnet_ids.Public.ids}"]
}

resource "aws_security_group" "Private_SG1" {
  name   = "NJ_PRIV1_SG1_TF"
  vpc_id = "vpc-0f908d460573e6f37"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["${data.aws_subnet.example.*.cidr_block}"]
  }
}

# resource "aws_instance" "Private" {
#   ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
#   instance_type = "t2.micro"
#   key_name      = "${aws_key_pair.mykey.key_name}"
#   iam_instance_profile =    "S3-Admin-Access"
# }
#
# }

