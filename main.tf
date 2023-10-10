# based on https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

provider "aws" {
  access_key = "" # input access_key here
  secret_key = "" # input secret_key here
  region = "us-east-1"
  #profile = "Admin"
}

# create instance

resource "aws_instance" "web_server2" {
  ami           = "ami-x" # input AMI here
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id     = "" # input subnet ID here
  security_groups = ["sg-"] # input security group id here

  user_data = "${file("jenkins_installation.sh")}"

    tags = {
    "Name": "tf_made_instance"
  }
}

# output new instance IP
output "instance_ip" {
  value = aws_instance.web_server2.public_ip
}
