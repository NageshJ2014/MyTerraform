resource "aws_instance" "Public_Ec2" {
  # vpc_id               = "${aws_vpc.my_vpc.id}"
  count                = 3
  ami                  = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.mykey.key_name}"
  iam_instance_profile = "S3-Admin-Access"
  subnet_id            = "${element(aws_subnet.Public_Subnet.*.id, count.index)}"

  user_data = "${file("../scripts/install.sh")}"

  # This Connection string does not matter for user data, But matters for
  # remote_connection and others
  # connection {
  #   user        = "${var.INSTANCE_USERNAME}"
  #   private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  # }

  tags {
    Name   = "Web Server ${count.index+1}"
    Reason = "Creating Full VPC"
  }
  # security_groups = ["sg-04baec5d0ded316e8"]
  vpc_security_group_ids = ["${aws_security_group.Public_Web_SG1.id}"]
}

resource "aws_security_group" "Public_Web_SG1" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  tags = {
    Name = "Public_Web_SG1"
    Type = "All Open Ports"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
