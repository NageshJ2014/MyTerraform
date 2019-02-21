resource "aws_key_pair" "mykey" {
  key_name   = "njkey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

data "aws_availability_zones" "all" {}

output "All_AZ" {
  value = "${data.aws_availability_zones.all.names}"
}

# resource "aws_instance" "example" {
#   ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
#   instance_type = "t2.micro"
#   key_name      = "${aws_key_pair.mykey.key_name}"
#   iam_instance_profile = "S3-Admin-Access"
#   # security_groups = ["sg-0bcc5c5a67088a914"]
#
#   provisioner "file" {
#     source      = "script.sh"
#     destination = "/tmp/script.sh"
#   }
#
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/script.sh",
#       "sudo /tmp/script.sh",
#     ]
#   }
#
#   connection {
#     user        = "${var.INSTANCE_USERNAME}"
#     private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
#   }
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

