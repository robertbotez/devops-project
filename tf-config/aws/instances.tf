resource "aws_key_pair" "vm_key_pair" {
  key_name = "vm_key_pair"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "master_instance" {
  count = var.aws_master_count

  tags = {
    Name = "master${count.index + 1}"
  }

  ami           = "ami-0ab1a82de7ca5889c"
  instance_type = var.aws_instance_type
  #subnet_id     = aws_subnet.subnet_1.id
  #availability_zone = "eu-central-1a"

  subnet_id = aws_subnet.subnet[0].id

  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]

  key_name = aws_key_pair.vm_key_pair.key_name

  security_groups = [aws_security_group.my_security_group.id]
}

resource "aws_instance" "worker_instances" {
  count = var.aws_worker_count

  tags = {
    Name = "worker${count.index + 1}"
  }

  ami           = "ami-0ab1a82de7ca5889c"
  instance_type = var.aws_instance_type
  #subnet_id     = aws_subnet.subnet_1.id
  #availability_zone = "eu-central-1a"

  subnet_id = aws_subnet.subnet[count.index + 1].id

  availability_zone = var.availability_zones[(count.index + 1) % length(var.availability_zones)]


  key_name = aws_key_pair.vm_key_pair.key_name

  security_groups = [aws_security_group.my_security_group.id]
}


resource "null_resource" "provision_master_hosts_file" {
  #vm_count = aws_instance.vm_instance.count

  provisioner "local-exec" {
  command = "echo '${join("\n", formatlist("%v", aws_eip.master_eip.*.public_ip))}' | awk 'BEGIN{ print \"\\n\\n# Master:\" }; { print $0 \" ${var.master_member_name_prefix}\" NR }' | sudo tee -a /etc/hosts > /dev/null | echo '${join("\n", formatlist("%v", aws_eip.master_eip.*.public_ip))}' | awk 'BEGIN{ print \"\\n\\n# Master:\" }; { print $0 \" ${var.master_member_name_prefix}\" NR }' | sudo tee -a ../../hosts > /dev/null"
  }
  triggers = {
  cluster_instance_ids = join(",", aws_instance.master_instance.*.id)
  #build_number = "${timestamp()}"
  }
}

resource "null_resource" "provision_worker_hosts_file" {
  #vm_count = aws_instance.vm_instance.count

  provisioner "local-exec" {
  command = "echo '${join("\n", formatlist("%v", aws_eip.worker_eip.*.public_ip))}' | awk 'BEGIN{ print \"\\n\\n# Workers:\" }; { print $0 \" ${var.worker_member_name_prefix}\" NR }' | sudo tee -a /etc/hosts > /dev/null | echo '${join("\n", formatlist("%v", aws_eip.worker_eip.*.public_ip))}' | awk 'BEGIN{ print \"\\n\\n# Workers:\" }; { print $0 \" ${var.worker_member_name_prefix}\" NR }' | sudo tee -a ../../hosts > /dev/null"
  }
  triggers = {
  cluster_instance_ids = join(",", aws_instance.worker_instances.*.id)
  #build_number = "${timestamp()}"
  }
}
