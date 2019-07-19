resource "aws_s3_bucket" "test_app_alb_logs" {
  bucket = "test-bucket-sta21-appserver-alb1"
  acl    = "private"

  tags = {
    Name        = "testappserverbucketsta21"
    Environment = "Test Dev"
  }
}
resource "aws_s3_bucket" "test_web_alb_logs" {
  bucket = "test-bucket-sta21-webserver-alb2"
  acl    = "private"

  tags = {
    Name        = "testwebserverbucketsta21"
    Environment = "Test Dev"
  }
}

