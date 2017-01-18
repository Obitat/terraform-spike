/* Private subnet */
resource "aws_subnet" "private_primary" {
  vpc_id                  = "${aws_vpc.obitat.id}"
  cidr_block              = "${var.private_subnet_cidr_primary}"
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = false
  depends_on              = ["aws_instance.nat"]

  tags {
    Name = "private"
  }
}

resource "aws_subnet" "private_secondary" {
  vpc_id                  = "${aws_vpc.obitat.id}"
  cidr_block              = "${var.private_subnet_cidr_secondary}"
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = false
  depends_on              = ["aws_instance.nat"]

  tags {
    Name = "private"
  }
}

resource "aws_subnet" "private_tertiary" {
  vpc_id                  = "${aws_vpc.obitat.id}"
  cidr_block              = "${var.private_subnet_cidr_tertiary}"
  availability_zone       = "${data.aws_availability_zones.available.names[2]}"
  map_public_ip_on_launch = false
  depends_on              = ["aws_instance.nat"]

  tags {
    Name = "private"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "private_primary" {
  subnet_id      = "${aws_subnet.private_primary.id}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "private_secondary" {
  subnet_id      = "${aws_subnet.private_secondary.id}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "private_tertiary" {
  subnet_id      = "${aws_subnet.private_tertiary.id}"
  route_table_id = "${aws_route_table.private.id}"
}
