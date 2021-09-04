resource "aws_db_instance" "graylogdb" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "graylogdb"
  username             = "sqluser"
  password             = "Access110$"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
