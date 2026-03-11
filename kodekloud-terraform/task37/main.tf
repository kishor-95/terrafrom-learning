resource "aws_eip" "eip" {
    domain = "vpc"
    
    tags = {
        Name = var.KKE_eip
    }
}
