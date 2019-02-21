resource "aws_key_pair" "mykey" {
  key_name   = "njkey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "example" {
  count         = 1
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.mykey.key_name}"

  user_data              = "${file("../scripts/install.sh")}"
  vpc_security_group_ids = ["sg-beeecdff"]

#  connection {
#    user        = "${var.INSTANCE_USERNAME}"
#    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
#  }

  # provisioner "file" {
  #   source      = "script.sh"
  #   destination = "/tmp/script.sh"
  # }
  #
  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/script.sh",
  #     "sudo /tmp/script.sh",
  #   ]
  # }
  #
  # provisioner "local-exec" {
  #   command = "echo ${aws_instance.example.public_dns} >> Tags.txt"
  # }

  tags {
    Name   = "Test-Terraform"
    Type   = "First Terraform Test Ec2 Instance "
    Reason = "Local Command Not Working"
  }
}

#
# data "aws_ami_ids" "ubuntu" {
#   #executable_users = ["self"]
#   owners = ["063491364108"]
# }
#
# variable "MY_AMI" {
#   type    = "list"
#   default = ["TEST1", "TEST2", "TEST3"]
# }
#
# output "ALL AMIS" {
#   value = ["${data.aws_ami_ids.ubuntu.ids}"]
#
#
# }
#
# output "Public IP" {
#   value = "${aws_instance.example.public_ip}"
# }

# resource "aws_instance" "Example" {
#   ami = "${lookup(var.AMIS,var.AWS_REGION)}"
#   instance_type = "t2.micro"
#
#   tags  {
#   Name = "Test-Terraform"
#   Type = "First Terraform Test Ec2 Instance "
# 	Reason = "NOt Changing"
#
#   }
# }

# resource "aws_instance" "eb2" {
# 	ami = "${aws_instance.Example.ami}"
# 	tags = "${aws_instance.Example.tags}"
# 	instance_type = "t2.micro"
# 	key_name = "${aws_key_pair.mykey.key_name}"
# }
# resource "aws_s3_bucket" "b" {
#   bucket = "nj11testterraform"
#   acl    = "private"
#
#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }

data "aws_availability_zones" "all" {}

output "All_AZ" {
  value = "${data.aws_availability_zones.all.names}"
}
