/*resource "aws_route53_record" "dns_record" {
  count = var.aws_instance_count

  zone_id = var.aws_route53_zone_id
  name    = "vm-${count.index + 1}.rbotez.com"
  type    = "A"

  ttl     = "300"
  records = [aws_instance.vm_instance[count.index].private_ip]
}
*/
