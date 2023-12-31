module "vpc" {
  source                 = "git::https://github.com/sivalingam2/tf-vpc-module.git"
  for_each = var.vpc

 cidr                      = each.value["cidr"]
  subnets                  = each.value["subnets"]
  default_vpc_id           = var.default_vpc_id
  default_vpc_cidr         = var.default_vpc_cidr
  default_vpc_route_table_id = var.default_vpc_route_table_id
  tags                       = var.tags
  env                        = var.env

}
module "alb" {
  source                 = "git::https://github.com/sivalingam2/alb_module.git"
  for_each = var.alb
  internal = each.value["internal"]
  lb_type  = each.value["lb_type"]
  sg_ingress_cidr = each.value["sg_ingress_cidr"]
  vpc_id = each.value["internal"] ? local.vpc_id : var.default_vpc_id
  subnets = each.value["internal"] ?  local.app_subnets : data.aws_subnets.subnets.ids
  tags                       = var.tags
  env                        = var.env
  sg_port = each.value["sg_port"]

}
module "document_db" {
  source                 = "git::https://github.com/sivalingam2/module_documentdb.git"
  for_each = var.document_db
  tags                       = var.tags
  env                        = var.env
  subnet_ids                 = local.db_subnets
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]
  vpc_id               = local.vpc_id
  sg_ingress_cidr      = local.app_subnets_cidr
  engine_version       = each.value["engine_version"]
  engine_family        = each.value["engine_family"]
  engine               = each.value["engine"]
  instance_count       = each.value["instance_count"]
  instance_class       = each.value["instance_class"]
}
module "rds" {
  source                 = "git::https://github.com/sivalingam2/module_rds.git"
  for_each = var.rds
  tags                       = var.tags
  env                        = var.env
  subnet_ids                 = local.db_subnets
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]
  vpc_id               = local.vpc_id
  sg_ingress_cidr      = local.app_subnets_cidr
  engine_version       = each.value["engine_version"]
  engine_family        = each.value["engine_family"]
  engine               = each.value["engine"]
  instance_count       = each.value["instance_count"]
  instance_class       = each.value["instance_class"]
  db_port              = each.value["db_port"]
  rds_type             = each.value["rds_type"]
}
module "elastic_cache" {
  source                 = "git::https://github.com/sivalingam2/module_elastic_cahe.git"
  for_each = var.elastic_cache
  tags                       = var.tags
  env                        = var.env
  subnet_ids                 = local.db_subnets
  vpc_id               = local.vpc_id
  sg_ingress_cidr      = local.app_subnets_cidr
  engine_family               = each.value["engine_family"]
  elasticcache_type             = each.value["elasticcache_type"]
  engine               = each.value["engine"]
  node_type            = each.value["node_type"]
  num_cache_nodes      = each.value["num_cache_nodes"]
  engine_version       = each.value["engine_version"]
  port                 = each.value["port"]
}

module "rabbitmq" {
  source                 = "git::https://github.com/sivalingam2/tf_module_rabbitmq.git"
  for_each = var.rabbitmq
  tags                       = var.tags
  env                        = var.env
  subnet_ids                 = local.db_subnets
  vpc_id               = local.vpc_id
  sg_ingress_cidr      = local.app_subnets_cidr
  ssh_ingress_cidr     = var.ssh_ingress_cidr
  ami                  = var.ami
  instance_type        = each.value["instance_type"]
  zone_id              = var.zone_id


}
module "app" {
  source                 = "git::https://github.com/sivalingam2/tf_module_app.git"

  tags                       = var.tags
  env                        = var.env
  ssh_ingress_cidr     = var.ssh_ingress_cidr
  ami                  = var.ami
  zone_id              = var.zone_id
  default_vpc_id           = var.default_vpc_id

  for_each = var.app
  instance_type        = each.value["instance_type"]
  component            = each.key
  port                  = each.value["port"]
  desired_capacity      = each.value["desired_capacity"]
  max_size             = each.value["max_size"]
  min_size             = each.value["min_size"]
  priority             = each.value["priority"]

  vpc_id               = local.vpc_id
  sg_ingress_cidr      = local.app_subnets_cidr
  subnet_ids            = local.app_subnets
  private_alb_name              = lookup(lookup(lookup(module.alb,"private", null ) , "alb", null) ,"dns_name", null)
  private_lb_listener           = lookup(lookup(lookup(module.alb,"private", null), "alb_listener", null) ,"arn", null)
  public_alb_name              = lookup(lookup(lookup(module.alb,"public", null ) , "alb", null) ,"dns_name", null)
  public_lb_listener           = lookup(lookup(lookup(module.alb,"public", null), "alb_listener", null) ,"arn", null)
}





