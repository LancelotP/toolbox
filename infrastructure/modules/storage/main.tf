locals {
  s3_management_app_name = "${var.prefix}-s3-management"

  bucket_uploads_name = "${var.prefix}-uploads"
  bucket_public_name  = "${var.prefix}-public"
  bucket_private_name = "${var.prefix}-private"
}

resource "scaleway_iam_application" "s3_management" {
  provider    = scaleway
  name        = local.s3_management_app_name
  description = "IAM Application to manage S3 buckets from Terraform"
}

module "s3_management_credentials" {
  source          = "../../utils/rotating-api-key"
  key_description = "API Key to manage S3 buckets from Terraform"
  iam_app_id      = scaleway_iam_application.s3_management.id
  project_id      = var.project_id
  rotation_days   = 30
  validity_days   = 90
}

resource "scaleway_iam_policy" "s3_full_access" {
  provider       = scaleway
  name           = "${local.s3_management_app_name}-FullAccess"
  description    = "Give full access to the S3 buckets in project"
  application_id = scaleway_iam_application.s3_management.id

  rule {
    project_ids          = [var.project_id]
    permission_set_names = ["ObjectStorageFullAccess"]
  }
}

provider "scaleway" {
  alias           = "s3_management"
  access_key      = module.s3_management_credentials.access_key
  secret_key      = module.s3_management_credentials.secret_key
  organization_id = var.organization_id
  project_id      = var.project_id
  region          = var.region
  zone            = var.zone
}

locals {
  bucket_management_statement = {
    Sid    = "BucketManagement"
    Effect = "Allow"
    Principal = {
      SCW = concat(
        ["user_id:${var.owner_id}"],
        ["application_id:${scaleway_iam_application.s3_management.id}"],
        [for id in var.developer_ids : "user_id:${id}"]
      )
    },
    Action = ["*"]
  }

  bucket_api_access_statement = {
    Sid    = "ApiAccess"
    Effect = "Allow"
    Principal = {
      SCW = "application_id:${var.iam_api_app_id}"
    },
    Action = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
    ],
  }
}

# Bucket used to store uploads temporarily
resource "scaleway_object_bucket" "uploads" {
  provider      = scaleway.s3_management
  name          = local.bucket_uploads_name
  project_id    = var.project_id
  force_destroy = true

  versioning {
    enabled = false
  }

  lifecycle_rule {
    id      = "lifecycle-expiration"
    enabled = true

    expiration {
      days = 1
    }
  }

  lifecycle_rule {
    id      = "lifecycle-abort-incomplete-multipart-upload"
    enabled = true

    abort_incomplete_multipart_upload_days = 1
  }
}

resource "scaleway_object_bucket_policy" "uploads" {
  provider   = scaleway.s3_management
  project_id = var.project_id
  bucket     = scaleway_object_bucket.uploads.id

  lifecycle {
    create_before_destroy = true
  }

  policy = jsonencode({
    Version = "2023-04-17"
    Id      = "${scaleway_object_bucket.uploads.name}-policy"
    Statement = [
      merge(local.bucket_management_statement, {
        Resource = [
          "${scaleway_object_bucket.uploads.name}",
          "${scaleway_object_bucket.uploads.name}/*"
        ]
      }),
      merge(local.bucket_api_access_statement, {
        Resource = [
          "${scaleway_object_bucket.uploads.name}",
          "${scaleway_object_bucket.uploads.name}/*"
        ]
      })
    ]
  })
}

resource "scaleway_object_bucket" "private" {
  provider      = scaleway.s3_management
  name          = local.bucket_private_name
  project_id    = var.project_id
  force_destroy = true

  versioning {
    enabled = false
  }
}

resource "scaleway_object_bucket_policy" "private" {
  provider   = scaleway.s3_management
  project_id = var.project_id
  bucket     = scaleway_object_bucket.private.id

  lifecycle {
    create_before_destroy = true
  }

  policy = jsonencode({
    Version = "2023-04-17"
    Id      = "${scaleway_object_bucket.private.name}-policy"
    Statement = [
      merge(local.bucket_management_statement, {
        Resource = [
          "${scaleway_object_bucket.private.name}",
          "${scaleway_object_bucket.private.name}/*"
        ]
      }),
      merge(local.bucket_api_access_statement, {
        Resource = [
          "${scaleway_object_bucket.private.name}",
          "${scaleway_object_bucket.private.name}/*"
        ]
      })
    ]
  })
}

resource "scaleway_object_bucket" "public" {
  provider      = scaleway.s3_management
  name          = local.bucket_public_name
  project_id    = var.project_id
  force_destroy = true

  # TODO: CORS rules
  versioning {
    enabled = false
  }
}

resource "scaleway_object_bucket_policy" "public" {
  provider   = scaleway.s3_management
  project_id = var.project_id
  bucket     = scaleway_object_bucket.public.id

  lifecycle {
    create_before_destroy = true
  }

  policy = jsonencode({
    Version = "2023-04-17"
    Id      = "${scaleway_object_bucket.public.name}-policy"
    Statement = [
      merge(local.bucket_management_statement, {
        Resource = [
          "${scaleway_object_bucket.public.name}",
          "${scaleway_object_bucket.public.name}/*"
        ]
      }),
      merge(local.bucket_api_access_statement, {
        Resource = [
          "${scaleway_object_bucket.public.name}",
          "${scaleway_object_bucket.public.name}/*"
        ]
      }),
      {
        Sid       = "PublicAccess"
        Effect    = "Allow"
        Principal = "*",
        Action    = ["s3:GetObject"],
        Resource  = ["${scaleway_object_bucket.public.name}/*"]
      }
    ]
  })
}
