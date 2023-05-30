
# Tags
variable "project" {}
variable "createdby" {}
# General 
variable "aws_region" {}

# CodeBuild
variable "project_name" {}
variable "project_desc" {}
variable "environment_compute_type" {}
variable "environment_image" {}
variable "environment_type" {}
variable "dockerhub_credentials" {}
variable "credential_provider" {}
variable "environment_variables" {}
variable "report_build_status" {}
variable "source_version" {}
variable "buildspec_file_absolute_path" {}
variable "vpc_id" {}
variable "subnets" {}
variable "security_group_ids" {}
variable "source_location" {}

# CodePipeline
variable "s3_bucket_id" {}
variable "full_repository_id" {}
variable "codestar_connector_credentials" {}

# -------------------------------------------
# Common Variables
# -------------------------------------------

variable "aws_region" {
  description = "AWS infrastructure regio"
  type        = string
  default     = null
}


variable "tags" {
  description = "Tag map for the resource"
  type        = map(string)
  default     = {}
}

# -------------------------------------------
# CodePipeline
# -------------------------------------------

variable "project_name" {
  description = "codebuild project name"
  type        = string
  default     = null
}

variable "s3_bucket_id" {
  description = "s3_bucket_id"
  type        = string
  default     = ""
}

variable "artifacts_store_type" {
  description = "Artifacts store type"
  type        = string
  default     = "S3"
}


variable "source_provider" {
  description = "source_provider"
  type        = string
  default     = "CodeStarSourceConnection"
}

variable "input_artifacts" {
  description = "input_artifacts"
  type        = string
  default     = "tf-code"
}

variable "output_artifacts" {
  description = "output_artifacts"
  type        = string
  default     = "tf-code"
}

variable "full_repository_id" {
  description = "full_repository_id"
  type        = string
  default     = ""
}

variable "branch_name" {
  description = "branch_name"
  type        = string
  default     = "main"
}

variable "codestar_connector_credentials" {
  description = "codestar_connector_credentials"
  type        = string
  default     = ""
}

variable "output_artifact_format" {
  description = "OutputArtifactFormat"
  type        = string
  default     = "CODE_ZIP"
}


variable "role_name" {
  description = "role_name"
  type        = string
  default     = "E2EsaTerraformCodePipelineRole"
}

variable "policy_name" {
  description = "policy_name"
  type        = string
  default     = "E2EsaTerraformCodePipelinePolicy"
}

variable "approve_sns_arn" {
  description = "SNS arn"
  type        = string
  default     = "sns"
}

variable "approve_comment" {
  description = "approval comment"
  type        = string
  default     = "Terraform code updated"
}

variable "approve_url" {
  description = "approval url"
  type        = string
  default     = "url"
}
