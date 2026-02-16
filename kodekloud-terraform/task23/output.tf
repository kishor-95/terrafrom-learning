output "nautilus" {
  value = aws_opensearch_domain.nautilus_es.domain_name
}
output "endpoint" {
      value = aws_opensearch_domain.nautilus_es.endpoint 
}

output "Domain_id" {
    value = aws_opensearch_domain.nautilus_es.domain_id
}
