data "aws_caller_identity" "current" {}
################################################
# ECS Log group
################################################
resource "aws_cloudwatch_log_group" "general-ecs-log-group" {
  name  = "/aws/ecs/${var.env_name}-${var.repository_name}-log"
  retention_in_days = "14"
  tags = {
    Name = "${var.repository_name} ECS Log Group"
  }
}

################################################
# Codebuild Log group
################################################
resource "aws_cloudwatch_log_group" "general-codebuild-log-group" {
  name  = "/aws/codebuild/${var.env_name}-${var.repository_name}-codebuild-log"
  retention_in_days = "14"
  tags = {
    Name = "Service ${var.repository_name} Codebuild Log Group"
  }
}

// khoi tao file env cho source code va push len s3
data "template_file" "general-env-file" {
  template = file("templates/${var.env_name}-${var.region_name}-${var.repository_name}.env") # Ex: prod-ohio-frontend-app.env
  vars = {
    DEBUG = true
  }
}
resource "aws_s3_object" "general-conf" {
  bucket  = var.s3_private_bucket
  key     = "cfg/${var.env_name}-${var.region_name}-${var.repository_name}.env"
  content = data.template_file.general-env-file.rendered
  etag    = filemd5("templates/${var.env_name}-${var.region_name}-${var.repository_name}.env")
}
// khoi tao file cicd cho tung project
resource "aws_s3_object" "general-artifact" {
  bucket = var.s3_private_bucket
  key    = "artifact/"
}
resource "aws_s3_object" "general-buildspec" {
  bucket = var.s3_private_bucket
  key    = "buildspec/"
}
data "template_file" "general-buildspec-file" {
  template = file("buildspecs/buildspec.yaml")
  vars = {
      REPOSITORY_VERSION     = var.repository_version
      REPOSITORY_NAME        = var.repository
      AWS_ACCESS_KEY_ID      = var.iam_access_key_id
      AWS_SECRET_ACCESS_KEY  = var.iam_access_key_secret
      AWS_REGION             = var.region
      EXECUTION_ROLE_ARN     = var.ecs_tasks_role_arn
      TASK_DEFINITION_FAMILY = var.ecs_tasks_definition_family
      AWS_ACCOUNT_ID         = data.aws_caller_identity.current.account_id
      LOGS_GROUP             = aws_cloudwatch_log_group.general-ecs-log-group.id
      ENV_ARN                = "arn:aws:s3:::${var.s3_private_id}/${aws_s3_object.general-conf.key}"
      PORT                   = var.port
      TASK_ROLE_ARN          = ""
  }
}
resource "aws_s3_object" "general-buildspec-file" {
  bucket  = var.s3_private_bucket
  key     = "buildspec/${var.env_name}-${var.region_name}-${var.repository_name}-buildspec.yaml"
  content = data.template_file.general-buildspec-file.rendered
  etag    = filemd5("buildspecs/buildspec.yaml")
}
data "template_file" "general-appspec-file" {
  template = file("buildspecs/appspec.yaml")
  vars = {
    PORT  = var.port
  }
}
resource "aws_s3_object" "general-appspec-file" {
  bucket  = var.s3_private_bucket
  key     = "buildspec/${var.env_name}-${var.region_name}-${var.repository_name}-appspec.yaml"
  content = data.template_file.general-appspec-file.rendered
  etag    = filemd5("buildspecs/appspec.yaml")
}
data "template_file" "general-taskdef-file" {
  template = file("buildspecs/taskdef.json")
  vars = {
    REPOSITORY_NAME        = var.repository
    REPOSITORY_VERSION     = var.repository_version
    PORT                   = var.port
  }
}
resource "aws_s3_object" "general-taskdef-file" {
  bucket  = var.s3_private_bucket
  key     = "buildspec/${var.env_name}-${var.region_name}-${var.repository_name}-taskdef.json"
  content = data.template_file.general-taskdef-file.rendered
  etag    = filemd5("buildspecs/taskdef.json")
}