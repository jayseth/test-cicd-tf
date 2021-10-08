output "ebs_volume" {
  value = aws_ebs_volume.test_volume.arn
}

# output "ebs_snap_arn" {
#     value = local.snap_arn
# }

# output "ebs_snap_id" {
#     value = local.snap_id
# }

# output "ebs_snap_size" {
#     value = local.snap_size
# }

output "dlm_ploicy" {
    value = aws_dlm_lifecycle_policy.dlm_policy.policy_details
}