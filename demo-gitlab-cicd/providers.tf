terraform {
  required_version = ">= 1.0.3"
  backend "s3" {
    bucket = "tf-backend-state"
    key    = "terraform.tfstate"
    region = "eu-central-1"
    profile = "terraform"
  }
}


provider "aws" {
         region         = "eu-central-1"
         profile        = "terraform"
}

