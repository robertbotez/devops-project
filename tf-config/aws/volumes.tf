resource "aws_ebs_volume" "ebs_volume_master" {
  count = var.aws_master_count
  #availability_zone = "eu-central-1a"
  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]
  size = var.aws_ebs_volume_size
}

resource "aws_volume_attachment" "ebs_attach_master" {
  count       = var.aws_master_count
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.ebs_volume_master[count.index].id
  instance_id = aws_instance.master_instance[count.index].id
}

resource "aws_ebs_volume" "ebs_volume_worker" {
  count             = var.aws_worker_count
  #availability_zone = "eu-central-1a"
  availability_zone = var.availability_zones[(count.index + 1) % length(var.availability_zones)]
  size = var.aws_ebs_volume_size
}

resource "aws_volume_attachment" "ebs_attach_worker" {
  count       = var.aws_worker_count
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.ebs_volume_worker[count.index].id
  instance_id = aws_instance.worker_instances[count.index].id
}
