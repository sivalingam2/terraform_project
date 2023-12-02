 components = {
   frontend = {
     name          = "frontend"
     instance_type = "t3.micro"
   }
   catalogue = {
     name          = "catalogue"
     instance_type = "t3.micro"
   }
   mongodb = {
     name          = "mongodb"
     instance_type = "t3.micro"
   }
   cart = {
     name          = "cart"
     instance_type = "t3.micro"
   }
   user = {
     name          = "user"
     instance_type = "t3.micro"
   }
   redis = {
     name          = "redis"
     instance_type = "t3.micro"
   }
   mysql = {
     name          = "mysql"
     instance_type = "t3.micro"
   }
   shipping = {
     name          = "shipping"
     instance_type = "t3.micro"
   }
   payment = {
     name          = "payment"
     instance_type = "t3.micro"
   }
   dispatch = {
     name          = "dispatch"
     instance_type = "t3.micro"
   }
   rabbitmq = {
     name          = "rabbitmq"
     instance_type = "t3.micro"
   }
 }
 ami = "ami-03265a0778a880afb"

 vpc_security_group_ids = [ "sg-07bf8bea064a5f22c"]

 zone_id = "Z02456543UCI8DLI5F070"


