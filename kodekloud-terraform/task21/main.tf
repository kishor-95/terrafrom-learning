
variable "group_name" {
    default = "devops-log-group"
    type    = string
}

variable "log_stream" {
    default = "devops-log-stream"
    type    = string
}

resource "aws_cloudwatch_log_group" "devops_log_group" {
  name = var.group_name
}

resource "aws_cloudwatch_log_stream" "foo" {
  name           = var.log_stream
  log_group_name = aws_cloudwatch_log_group.devops_log_group.name
}
