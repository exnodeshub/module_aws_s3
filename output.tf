output "s3_object_config_key" {
  description = "S3 private config key"
  value       = aws_s3_object.general-conf.key
}
output "s3_object_buildspec_file" {
  description = "S3 object buildspec file"
  value       = aws_s3_object.general-buildspec-file
}
output "s3_object_appspec_file" {
  description = "S3 object appspec file"
  value       = aws_s3_object.general-appspec-file
}
output "s3_object_taskdef_file" {
  description = "S3 object taskdef file"
  value       = aws_s3_object.general-taskdef-file
}
output "s3_ecs_log_group_id" {
  description = "S3 ecs log group id"
  value       = aws_cloudwatch_log_group.general-ecs-log-group.id
}
output "s3_codebuild_log_group_id" {
  description = "S3 code build log group id"
  value       = aws_cloudwatch_log_group.general-codebuild-log-group.id
}
output "s3_codebuild_log_group_name" {
  description = "S3 code build log group name"
  value       = aws_cloudwatch_log_group.general-codebuild-log-group.name
}