resource "aws_elb" "my_elb" {
  name = "MY-NJ-ELB"

  subnets = ["${aws_subnet.Public_Subnet.*.id}"]

  # availability_zones = ["${aws_subnet.Public_Subnet.*.availability_zone}"]
  security_groups = ["${aws_security_group.Public_Web_SG1.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    target              = "HTTP:80/index.html"
    interval            = 10
  }

  instances                   = ["${aws_instance.Public_Ec2.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name        = "ELB FROM TERRAFROM"
    Description = "Provisioned by Terraform"
  }
}

output "ELB_DNS" {
  value = "${aws_elb.my_elb.dns_name}"
}
