# Creating an EBS Volume(dlm policy will be applied to volume resources with tags attribute equal to target_tags attribute in dlm policy)
resource "aws_ebs_volume" "test_volume" {
  availability_zone = var.ebs_availability_zone
  encrypted         = var.ebs_encrypted
  size              = var.ebs_size
  tags = {
    Snapshot = var.ebs_snap
  }
}

# Creating a Snapshot for the EBS Volume created above
resource "aws_ebs_snapshot" "ebs_vol_snapshot" {
  count = tobool(aws_ebs_volume.test_volume.tags.Snapshot)?1:0
  volume_id = aws_ebs_volume.test_volume.id
}

# Creating a Data Lifecycle Manager policy and attching it to a role(Only the basic role is hard coded . dlm policy can be set using the variables)
resource "aws_dlm_lifecycle_policy" "dlm_policy" {
  description        = "example DLM lifecycle policy"
  execution_role_arn = aws_iam_role.dlm_lifecycle_role.arn
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = "2 weeks of daily snapshots"

      create_rule {
        interval      = var.ebs_dlm_policy_interval
        interval_unit = var.ebs_dlm_policy_interval_unit
        times         = var.ebs_dlm_policy_times
      }

      retain_rule {
        count = var.ebs_dlm_policy_retain_count
      }

      tags_to_add = {
        SnapshotCreator = "DLM"
      }

      copy_tags = false
    }

    target_tags = {
      Snapshot = "true"
    }
  }
}