variable "consul_service_conf" {
  default = "debian_upstart.conf"
}

variable "consul_service_conf_dest" {
  default = "upstart.conf"
}

variable "consul_servers" {
  default = "0"

  description = "The number of Consul servers to launch."
}

variable "consul_instance_type" {
  default = "t2.nano"

  description = "AWS Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types "
}

variable "tagName" {
  default = "consul"

  description = "Name tag for the servers"
}

resource "aws_instance" "consul_server" {
  ami                    = "${lookup(var.ami, "${var.region}-${var.platform}")}"
  instance_type          = "${var.consul_instance_type}"
  key_name               = "${aws_key_pair.deployer.key_name}"
  count                  = "${var.consul_servers}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  subnet_id = "${element(list(aws_subnet.private_primary.id, 
                              aws_subnet.private_secondary.id, 
                              aws_subnet.private_tertiary.id), 
                         count.index % 3)}"

  connection {
    user        = "ubuntu"
    private_key = "${file("${path.module}/ssh/insecure-deployer")}"
  }

  #Instance tags
  tags {
    Name       = "${var.tagName}-${count.index}"
    ConsulRole = "Server"
  }

  provisioner "file" {
    source      = "${path.module}/scripts/${var.consul_service_conf}"
    destination = "/tmp/${var.consul_service_conf_dest}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${var.consul_servers} > /tmp/consul-server-count",
      "echo ${aws_instance.consul_server.0.private_dns} > /tmp/consul-server-addr",
    ]
  }

  provisioner "remote-exec" {
    scripts = [
      "${path.module}/scripts/install.sh",
      "${path.module}/scripts/service.sh",
    ]
  }
}

output "infra_consul_servers" {
  value = "${join(",", aws_instance.consul_server.*.private_ip)}"
}
