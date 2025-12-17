variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for EC2 instance"
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs for EC2"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to EC2"
  type        = map(string)
  default     = {}
}
