module "components" {
  source                 = "./tf-vpc-module"
  for_each = var.vpc
  cidr = each.value["cidr"]

}
