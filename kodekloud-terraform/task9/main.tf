resource "aws_ebs_volume" "example" {
    size = 2
    type = "gp3"
    availability_zone = "us-east-1"

    tags = {
        Name = "nautilus-volume"
    }
}
