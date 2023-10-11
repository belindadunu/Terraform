# based on https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = "us-east-1"
  #profile = "Admin"
}

# create instance

resource "aws_instance" "tf_activity" {
  ami           = var.ami
  instance_type = var.instance_type
  associate_public_ip_address = true
  subnet_id     = var.subnet_id
  security_groups = var.security_groups
  key_name = var.key_name

  user_data = "${file("jenkins_installation.sh")}"

    tags = {
    "Name": var.instance_name
  }
}

# output new instance IP
output "instance_ip" {
  value = aws_instance.tf_activity.public_ip
}
