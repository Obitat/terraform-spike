resource "aws_vpc" "obitat" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"

    tags {
        Name = "obitat"    
    }
}

data "aws_availability_zones" "available" {}

variable "cidr_blocks" {
  type    = "list"
  default = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20", "10.0.48.0/20"]
}

resource "aws_subnet" "public" {
    count = 4
    cidr_block = "${var.cidr_blocks[count.index % 4]}"
    vpc_id = "${aws_vpc.obitat.id}"
    availability_zone = "${data.aws_availability_zones.available.names[count.index % 4]}"

    tags {
        Name = "public"
    }
}
