variable AWS_ACCESS_KEY {}
variable AWS_SECRET_KEY {}

variable AWS_REGION {
  default = "us-east-1"
}

variable "AMIS" {
  type = "map"

  default = {
    us-east-1 = "ami-0f9cf087c1f27d9b1"
    us-east-2 = "ami-0f9cf087c1f27d9b1"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "njkey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "njkey.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
