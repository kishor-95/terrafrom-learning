

resource "aws_opensearch_domain" "nautilus_es" {
  domain_name    = var.name
  engine_version = var.engine

  tags = {
    Domain = "nautilus-es"
  }
}

