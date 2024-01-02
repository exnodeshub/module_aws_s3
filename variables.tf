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