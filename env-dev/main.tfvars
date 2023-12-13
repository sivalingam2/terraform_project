vpc = {
  main = {
    cidr = "10.0.0.0/16"

  subnets = {
    public = {
      public1 = { cidr = "10.0.1.0/24" , az = "us-east-1a" }
      public2 = { cidr = "10.0.2.0/24" , az = "us-east-1b" }
    }
    app = {
      app1 = { cidr = "10.0.3.0/24" , az = "us-east-1a" }
      app2 = { cidr = "10.0.4.0/24" , az = "us-east-1b" }
    }
    db = {
      db1 = { cidr = "10.0.5.0/24" , az = "us-east-1a" }
      db2 = { cidr = "10.0.6.0/24" , az = "us-east-1b" }
    }
  }
  }
}
default_vpc_id = "vpc-0f12910c6a4b76385"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_route_table_id = "rtb-075dd482abc6dea71"

tags = {
  company_name = "ABC Company"
  business_unit = "learning"
  cost_center = "ecommerce"
  created_by = "siva"
  project_name = "roboshop"
}
env = "dev"

alb = {
  public = {
    lb_type = "application"
    internal = false
    sg_port =80
    sg_ingress_cidr = [ "0.0.0.0/0"]
  }
  private = {
    lb_type = "application"
    internal = true
    sg_port =80
    sg_ingress_cidr = [ "172.31.0.0/16", "10.0.0.0/16"]
  }
}
document_db = {
main = {
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  engine_version          = "4.0.0"
  engine_family           = "docdb4.0"
  engine                  = "docdb"
  instance_count          = 1
  instance_class          = "db.t3.medium"
}
}
rds = {
  main = {
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    engine_version          = "5.7.mysql_aurora.2.11.3"
    engine_family           = "aurora-mysql5.7"
    engine                  = "aurora-mysql"
    instance_count          = 1
    instance_class          = "db.t3.small"
    db_port                = 3306
    rds_type                = "mysql"

  }

}

elastic_cache = {
  main = {
    elasticcache_type    = "redis"
    engine               = "redis"
    engine_family        = "redis6.x"
    node_type            = "cache.t3.micro"
    num_cache_nodes      = 1
    engine_version       = "6.2"
    port                 = 6379

  }
}
rabbitmq = {
  main = {
    ami                   = "ami-03265a0778a880afb"
    instance_type         = "t3.micro"
    ssh_ingress_cidr      = ["172.31.41.146/32"]
    zone_id =     "Z02456543UCI8DLI5F070"
  }

}


