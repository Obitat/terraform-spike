provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# module "consul" {
#     source = "github.com/hashicorp/consul/terraform/aws"

#     key_name = "consul"
#     key_path = "consul.pem"
#     region = "us-east-1"
#     servers = "3"
# } 