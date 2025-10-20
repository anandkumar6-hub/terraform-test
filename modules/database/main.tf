resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(
    var.tags,
    { Name = "${var.project_name}-db-subnet-group" }
  )
}
resource "aws_db_instance" "this" {
  identifier        = "${var.project_name}-db"
  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  allocated_storage = 20
  db_name           = var.db_name
  username          = var.db_username
  password          = var.db_password
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.db_sg_id]
  publicly_accessible   = false
  skip_final_snapshot   = true

  tags = merge(
    var.tags,
    { Name = "${var.project_name}-db" }
  )
}
