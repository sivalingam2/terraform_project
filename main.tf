module "components" {

  source                 = "git::https://github.com/sivalingam2/tf-vpc-module"
  for_each = var.vpc
 cidr = each.value["cidr"]
}
