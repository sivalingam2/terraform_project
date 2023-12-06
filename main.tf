module "components" {
  source                 = "git::https://github.com/sivalingma2/tf-vpc-module"
  for_each = var.vpc
  cidr = each.value["cidr"]

}
