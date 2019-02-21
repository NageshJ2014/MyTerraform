terraform {
  backend "s3" {
    bucket = "nj-backend-state"
    key    = "terraform/nj_backend_state"
    region = "us-east-1"
  }
}
