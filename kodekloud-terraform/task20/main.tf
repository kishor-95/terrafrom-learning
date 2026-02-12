resource "aws_ssm_parameter" "foo" {
  name  = "devops-ssm-parameter"
  type  = "String"
  value = "devops-value"
}
