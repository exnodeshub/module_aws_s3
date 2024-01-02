# module_aws_vpc  
My module vpc aws

## Getting started  
config git credentical for private repo   
href: https://gitlab.com/exnodes-new/terraform-core/-/tree/master/modules/module_aws_s3?ref_type=heads

add module    
example:       
```JavaScript

module "example_s3" {
  source = "./modules/module_aws_s3"
  s3_private_id = "your s3 bucket private id"
  s3_private_bucket = "your s3 bucket private"
  # IAM role
  iam_access_key_secret = "your access key secret"
  iam_access_key_id = "your access key id"
  ecs_tasks_role_arn = "your ecs task role arn"
  # ECS
  repository_version = "your repository version, Ex: latest, staging, develop"
  region = "your region, Ex: `us-east-2`"
  region_name = "your region, Ex: `tokyo`"
  repository_name = "your repository name, Ex: `service-api`"
  repository = "your repository, Ex: `service.api`"
  env_name = "your environment name, Ex: `prod`"
  port = 80
  ecs_tasks_definition_family = "your ecs task definition family"
}
```

# Input 
```JavaScript
variable "env_name" {
    description = "ENV from root env"
    type = string
}
variable "repository_name" {
    description = "Repository"
    type = string
}
variable "region" {
    description = "AWS Region"
    type        = string
}
variable "region_name" {
    description = "Region name, Ex: Ohio, sgp, etc"
    type        = string
}
variable "s3_private_bucket" {
    description = "S3 private bucket"
    type = string
}
variable "repository" {
  description = "Repository"
  type = string
}
variable "repository_version" {
  description = "Repository version"
  type = string
}
variable "iam_access_key_id" {
    description = "aws_iam_access_key id"
    type = string
}
variable "iam_access_key_secret" {
    description = "aws_iam_access_key secret"
    type = string
}
variable "ecs_tasks_role_arn" {
    description = "ECS task role from module VPC"
    type        = string
}
variable "ecs_tasks_definition_family" {
    description = "ECS task definition family from module ECS"
    type        = string
}
variable "s3_private_id" {
    description = "S3 private id"
    type = string
}
variable "port" {
    description = "Port of taskdef"
    type        = number
}
```

# Output 
```JavaScript
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
```