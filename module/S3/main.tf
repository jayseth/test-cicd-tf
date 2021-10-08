resource "aws_kms_key" "test_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "log_bucket" {
  acl    = var.s3_log-acl
}

resource "aws_s3_bucket" "test_bucket" {
  acl    = var.s3_bucket-acl

  website {
    index_document = var.s3_static-website
  }
  
  lifecycle_rule {
    enabled = var.s3_life-cycle-enabled

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  versioning {
    enabled = var.s3_enabled
  }

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.test_key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

}

resource "aws_s3_bucket_object" "website_file" {
  bucket = aws_s3_bucket.test_bucket.bucket
  key    = var.s3_static-website
  source = "module/s3/${var.s3_static-website}"
  acl = var.s3_bucket-acl
  server_side_encryption = "aws:kms"
  kms_key_id = aws_kms_key.test_key.arn
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.test_bucket.id
  policy = jsonencode({
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.test_bucket.arn,
          "${aws_s3_bucket.test_bucket.arn}/*",
        ]
      },
    ]
  })
}