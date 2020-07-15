output "url" {
  value = "${var.engine == "mysql" ? "mysql2" : aws_db_instance.database.engine}://${var.username}:${var.password}@${aws_db_instance.database.endpoint}/${var.name}"
}
