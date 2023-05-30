resource "aws_codepipeline" "this" {

  name     = var.project_name
  role_arn = aws_iam_role.this.arn

  artifact_store {
    type     = var.artifacts_store_type
    location = var.s3_bucket_id
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = var.source_provider
      version          = "1"
      output_artifacts = [var.output_artifacts]
      configuration = {
        FullRepositoryId     = var.full_repository_id
        BranchName           = var.branch_name
        ConnectionArn        = var.codestar_connector_credentials
        OutputArtifactFormat = var.output_artifact_format
      }
    }
  }

  stage {
    name = "Apply" #"Plan"
    action {
      name            = "Build"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = [var.input_artifacts]
      configuration = {
        ProjectName = var.project_name
      }
    }
  }

  # stage {
  #   name = "Approve"

  #   action {
  #     name            = "Approval"
  #     category        = "Approval"
  #     owner           = "AWS"
  #     provider        = "Manual"
  #     version         = "1"
  #     input_artifacts = [var.input_artifacts]
  #     configuration = {
  #       #NotificationArn = var.approve_sns_arn
  #       CustomData = var.approve_comment
  #       #ExternalEntityLink = var.approve_url
  #     }
  #   }
  # }

  # stage {
  #   name = "Deploy"
  #   action {
  #     name            = "Deploy"
  #     category        = "Build"
  #     provider        = "CodeBuild"
  #     version         = "1"
  #     owner           = "AWS"
  #     input_artifacts = [var.input_artifacts]
  #     configuration = {
  #       ProjectName = var.project_name
  #     }
  #   }
  # }

}



# terraform apply -var-file="app.tfvars" -var="createdby=e2esa"

locals {
  tags = {
    Project     = var.project
    createdby   = var.createdby
    CreatedOn   = timestamp()
    Environment = terraform.workspace
  }
}

module "codebuild" {
  source = "../../modules/e2esa-module-aws-codebuild"
  #source             = "git::https://github.com/e2eSolutionArchitect/terraform.git//providers/aws/modules/e2esa-module-aws-codebuild?ref=main"
  project_name             = var.project_name
  project_desc             = var.project_desc
  environment_compute_type = var.environment_compute_type
  environment_image        = var.environment_image
  environment_type         = var.environment_type
  source_location          = var.source_location
  # dockerhub_credentials        = var.dockerhub_credentials
  # credential_provider          = var.credential_provider
  environment_variables        = var.environment_variables
  report_build_status          = var.report_build_status
  source_version               = var.source_version
  buildspec_file_absolute_path = var.buildspec_file_absolute_path
  #vpc_id                       = var.vpc_id
  #subnets                      = var.subnets
  #security_group_ids           = var.security_group_ids
  tags = local.tags
}

# module "codebuild-apply" {
#   source = "../../modules/e2esa-module-aws-codebuild"
#   project_name             = "${var.project_name}-apply"
#   project_desc             = var.project_desc
#   environment_compute_type = var.environment_compute_type
#   environment_image        = var.environment_image
#   environment_type         = var.environment_type
#   source_location          = var.source_location
#   environment_variables        = var.environment_variables
#   report_build_status          = var.report_build_status
#   source_version               = var.source_version
#   buildspec_file_absolute_path = var.buildspec_file_absolute_path_apply
#   tags                         = local.tags
# }

module "codepipeline" {
  source = "../../modules/e2esa-module-aws-codepipeline"
  #source             = "git::https://github.com/e2eSolutionArchitect/terraform.git//providers/aws/modules/e2esa-module-aws-codepipeline?ref=main"
  project_name                   = var.project_name
  s3_bucket_id                   = var.s3_bucket_id
  full_repository_id             = var.full_repository_id
  codestar_connector_credentials = var.codestar_connector_credentials
  tags                           = local.tags
}
