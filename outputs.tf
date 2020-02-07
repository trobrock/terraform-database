output "url" {
  value = "${aws_db_instance.database.engine}://${var.username}:${var.password}@${aws_db_instance.database.endpoint}/${var.name}"
}
