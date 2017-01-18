resource "aws_subnet" "public_primary" {
  vpc_id                  = "${aws_vpc.obitat.id}"
  cidr_block              = "${var.public_subnet_cidr_primary}"
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = true
  depends_on              = ["aws_internet_gateway.obitat"]

  tags {
    Name = "public"
  }
}

resource "aws_subnet" "public_secondary" {
  vpc_id                  = "${aws_vpc.obitat.id}"
  cidr_block              = "${var.public_subnet_cidr_secondary}"
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = true
  depends_on              = ["aws_internet_gateway.obitat"]

  tags {
    Name = "public"
  }
}

resource "aws_subnet" "public_tertiary" {
  vpc_id                  = "${aws_vpc.obitat.id}"
  cidr_block              = "${var.public_subnet_cidr_tertiary}"
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = true
  depends_on              = ["aws_internet_gateway.obitat"]

  tags {
    Name = "public"
  }
}

resource "aws_route_table_association" "public_primary" {
  subnet_id      = "${aws_subnet.public_primary.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public_secondary" {
  subnet_id      = "${aws_subnet.public_secondary.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public_tertiary" {
  subnet_id      = "${aws_subnet.public_tertiary.id}"
  route_table_id = "${aws_route_table.public.id}"
}
