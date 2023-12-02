module "components" {

  source                 = "git::https://github.com/sivalingam2/remote_module.git"
  for_each = var.components
  ami                    = var.ami
  instance_type          = each.value["instance_type"]
  vpc_security_group_ids = var.vpc_security_group_ids
  zone_id                = var.zone_id
  name                   = each.value["name"]
}
