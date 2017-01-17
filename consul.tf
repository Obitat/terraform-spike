# variable "platform" {
#   default     = "ubuntu"
#   description = "The OS Platform"
# }

# variable "user" {
#   default = {
#     ubuntu  = "ubuntu"
#     rhel6   = "ec2-user"
#     centos6 = "centos"
#     centos7 = "centos"
#     rhel7   = "ec2-user"
#   }
# }

# variable "ami" {
#   description = "AWS AMI Id, if you change, make sure it is compatible with instance type, not all AMIs allow all instance types "

#   default = {
#     us-east-1-ubuntu      = "ami-fce3c696"
#     us-east-2-ubuntu      = "ami-b7075dd2"
#     us-west-1-ubuntu      = "ami-a9a8e4c9"
#     us-west-2-ubuntu      = "ami-9abea4fb"
#     eu-west-1-ubuntu      = "ami-47a23a30"
#     eu-central-1-ubuntu   = "ami-accff2b1"
#     ap-northeast-1-ubuntu = "ami-90815290"
#     ap-northeast-2-ubuntu = "ami-58af6136"
#     ap-southeast-1-ubuntu = "ami-0accf458"
#     ap-southeast-2-ubuntu = "ami-1dc8b127"
#     us-east-1-rhel6       = "ami-0d28fe66"
#     us-east-2-rhel6       = "ami-aff2a9ca"
#     us-west-2-rhel6       = "ami-3d3c0a0d"
#     us-east-1-centos6     = "ami-57cd8732"
#     us-east-2-centos6     = "ami-c299c2a7"
#     us-west-2-centos6     = "ami-1255b321"
#     us-east-1-rhel7       = "ami-2051294a"
#     us-east-2-rhel7       = "ami-0a33696f"
#     us-west-2-rhel7       = "ami-775e4f16"
#     us-east-1-centos7     = "ami-6d1c2007"
#     us-east-2-centos7     = "ami-6a2d760f"
#     us-west-1-centos7     = "ami-af4333cf"
#   }
# }

# variable "service_conf" {
#   default = {
#     ubuntu  = "debian_upstart.conf"
#     rhel6   = "rhel_upstart.conf"
#     centos6 = "rhel_upstart.conf"
#     centos7 = "rhel_consul.service"
#     rhel7   = "rhel_consul.service"
#   }
# }

# variable "service_conf_dest" {
#   default = {
#     ubuntu  = "upstart.conf"
#     rhel6   = "upstart.conf"
#     centos6 = "upstart.conf"
#     centos7 = "consul.service"
#     rhel7   = "consul.service"
#   }
# }

# variable "key_name" {
#   description = "SSH key name in your AWS account for AWS instances."
#   default = "consul"
# }

# variable "key_path" {
#   description = "Path to the private key specified by key_name."
#   default = "consul.pem"
# }

# variable "servers" {
#   default     = "3"
#   description = "The number of Consul servers to launch."
# }

# variable "instance_type" {
#   default     = "t2.micro"
#   description = "AWS Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types "
# }

# variable "tagName" {
#   default     = "consul"
#   description = "Name tag for the servers"
# }

# resource "aws_instance" "server" {
#     ami = "${lookup(var.ami, "${var.region}-${var.platform}")}"
#     instance_type = "${var.instance_type}"
#     key_name = "${var.key_name}"
#     count = "${var.servers}"
#     vpc_security_group_ids = ["${aws_security_group.consul.id}"]
#     subnet_id = "${element(aws_subnet.public.*.id, count.index)}" 

#     connection {
#         user = "${lookup(var.user, var.platform)}"
#         private_key = "${file("${var.key_path}")}"
#     }

#     #Instance tags
#     tags {
#         Name = "${var.tagName}-${count.index}"
#         ConsulRole = "Server"
#     }

#     provisioner "file" {
#         source = "${path.module}/scripts/${lookup(var.service_conf, var.platform)}"
#         destination = "/tmp/${lookup(var.service_conf_dest, var.platform)}"
#     }


#     provisioner "remote-exec" {
#         inline = [
#             "echo ${var.servers} > /tmp/consul-server-count",
#             "echo ${aws_instance.server.0.private_dns} > /tmp/consul-server-addr",
#         ]
#     }

#     provisioner "remote-exec" {
#         scripts = [
#             "${path.module}/scripts/install.sh",
#             "${path.module}/scripts/service.sh",
#             "${path.module}/scripts/ip_tables.sh",
#         ]
#     }
# }

# resource "aws_security_group" "consul" {
#     name = "consul_${var.platform}" 
#     vpc_id = "${aws_vpc.obitat.id}"
#     description = "Consul internal traffic + maintenance."

#     // These are for internal traffic
#     ingress {
#         from_port = 0
#         to_port = 65535
#         protocol = "tcp"
#         self = true
#     }

#     ingress {
#         from_port = 0
#         to_port = 65535
#         protocol = "udp"
#         self = true
#     }

#     // These are for maintenance
#     ingress {
#         from_port = 22
#         to_port = 22
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     // This is for outbound internet access
#     egress {
#         from_port = 0
#         to_port = 0
#         protocol = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
# }

# output "server_address" {
#     value = "${aws_instance.server.0.public_dns}"
# }