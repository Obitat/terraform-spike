variable "access_key" {}

variable "secret_key" {}

variable "region" {
  default = "eu-west-1"
}

variable "platform" {
  default     = "ubuntu"
  description = "The OS Platform"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_primary" {
  description = "CIDR for public subnet"
  default     = "10.0.0.0/24"
}

variable "public_subnet_cidr_secondary" {
  description = "CIDR for private subnet"
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_tertiary" {
  description = "CIDR for private subnet"
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr_primary" {
  description = "CIDR for public subnet"
  default     = "10.0.10.0/24"
}

variable "private_subnet_cidr_secondary" {
  description = "CIDR for private subnet"
  default     = "10.0.11.0/24"
}

variable "private_subnet_cidr_tertiary" {
  description = "CIDR for private subnet"
  default     = "10.0.12.0/24"
}

variable "ami" {
  description = "AWS AMI Id, if you change, make sure it is compatible with instance type, not all AMIs allow all instance types "

  default = {
    us-east-1-ubuntu      = "ami-fce3c696"
    us-east-2-ubuntu      = "ami-b7075dd2"
    us-west-1-ubuntu      = "ami-a9a8e4c9"
    us-west-2-ubuntu      = "ami-9abea4fb"
    eu-west-1-ubuntu      = "ami-47a23a30"
    eu-central-1-ubuntu   = "ami-accff2b1"
    ap-northeast-1-ubuntu = "ami-90815290"
    ap-northeast-2-ubuntu = "ami-58af6136"
    ap-southeast-1-ubuntu = "ami-0accf458"
    ap-southeast-2-ubuntu = "ami-1dc8b127"
    us-east-1-rhel6       = "ami-0d28fe66"
    us-east-2-rhel6       = "ami-aff2a9ca"
    us-west-2-rhel6       = "ami-3d3c0a0d"
    us-east-1-centos6     = "ami-57cd8732"
    us-east-2-centos6     = "ami-c299c2a7"
    us-west-2-centos6     = "ami-1255b321"
    us-east-1-rhel7       = "ami-2051294a"
    us-east-2-rhel7       = "ami-0a33696f"
    us-west-2-rhel7       = "ami-775e4f16"
    us-east-1-centos7     = "ami-6d1c2007"
    us-east-2-centos7     = "ami-6a2d760f"
    us-west-1-centos7     = "ami-af4333cf"
  }
}
