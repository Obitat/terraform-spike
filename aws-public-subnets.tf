# data "aws_availability_zones" "available" {}

# variable "cidr_blocks" {
#   type    = "list"
#   default = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20", "10.0.48.0/20"]
# }

# resource "aws_subnet" "public" {
#     count = 4
#     cidr_block = "${var.cidr_blocks[count.index % 4]}"
#     vpc_id = "${aws_vpc.obitat.id}"
#     availability_zone = "${data.aws_availability_zones.available.names[count.index % 4]}"

#     tags {
#         Name = "public"
#     }
# }

resource "aws_subnet" "public_primary" {
  vpc_id            = "${aws_vpc.obitat.id}"
  cidr_block        = "${var.public_subnet_cidr_primary}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  depends_on = ["aws_internet_gateway.obitat"]
  tags { 
    Name = "public" 
  }
}

resource "aws_subnet" "public_secondary" {
  vpc_id            = "${aws_vpc.obitat.id}"
  cidr_block        = "${var.public_subnet_cidr_secondary}"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
  depends_on = ["aws_internet_gateway.obitat"]
  tags { 
    Name = "public" 
  }
}

resource "aws_route_table_association" "public_primary" {
  subnet_id = "${aws_subnet.public_primary.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public_secondary" {
  subnet_id = "${aws_subnet.public_secondary.id}"
  route_table_id = "${aws_route_table.public.id}"
}