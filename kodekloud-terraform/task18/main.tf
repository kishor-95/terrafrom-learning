resource "aws_kinesis_stream" "test_stream" {
  name             = "devops-stream"
  shard_count       = 1

  tags = {
    Name = "devops-stream"
  }
}
