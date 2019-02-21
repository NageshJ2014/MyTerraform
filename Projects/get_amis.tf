data "aws_ami" "nat_ami" {
  most_recent = true

  #executable_users = ["self"]
  owners = ["063491364108"]
}

output "ALL AMIS" {
  value = "${data.aws_ami.nat_ami.image_id}"
}
