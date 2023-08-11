variable "aws_master_count" {
  description = "Number of master instances"
  default     = 1
}

variable "aws_instance_count" {
  description = "Number of master instances"
  default     = 3
}

variable "aws_worker_count" {
  description = "Number of worker instances"
  default     = 2
}

variable "aws_instance_type" {
  description = "AWS instance type"
  default     = "t2.micro"
}

variable "aws_subnet_cidr" {
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "aws_ebs_volume_size" {
  description = "Size of the EBS volume"
  default     = 10
}

variable "subnets" {
  description = "List of subnet CIDR blocks"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones"
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "aws_route53_zone_id" {
  description = "Route53 hosted zone ID"
  default = "www.demo.rbotez.com"
}

variable "master_member_name_prefix" {
  description = "Prefix to use when naming cluster members"
  default     = "master"
}

variable "worker_member_name_prefix" {
  description = "Prefix to use when naming cluster members"
  default     = "worker"
}
