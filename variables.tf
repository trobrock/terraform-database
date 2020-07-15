variable "name" {
  description = "The name of the logical database resource"
}

variable "vpc_id" {
  description = "The ID of the VPC to launch the database in"
}

variable "identifier" {
  description = "The identifier for the RDS instance"
}

variable "subnets" {
  type        = list(string)
  description = "The list of subnet IDs to make the database available in"
}

variable "security_groups" {
  type        = list(string)
  description = "The list of security groups that should be able to access the database"
}

variable "username" {
  description = "The username of the master database user"
  default     = "tfowner"
}

variable "password" {
  description = "The password of the master database user"
}

variable "allocated_storage" {
  description = "The storage allocated to the database in GB (minimum: 10)"
  default     = 10
}

variable "max_allocated_storage" {
  description = "The maximum amount of storage to allocate. Setting this enables storage autoscaling"
  default     = null
}

variable "backup_retention_period" {
  description = "The length of time in days to retain database backups"
  default     = 7
}

variable "engine_version" {
  description = "The version of the database engine to run"
  default     = "9.6.11"
}

variable "engine" {
  description = "The engine to use (ie postgres or mysql)"
  default     = "postgres"
}

variable "instance_class" {
  description = "The AWS instance type to launch the database on"
  default     = "db.t2.micro"
}

variable "storage_type" {
  description = "The storage type to use on the database"
  default     = "gp2"
}

variable "enable_encryption" {
  description = "A boolean defining whether the storage will be encrypted"
  type        = bool
  default     = false
}

variable "port" {
  description = "The port to use for the database, omit for engine default"
  default     = null
}
