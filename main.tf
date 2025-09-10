resource "aws_vpc" "main" {
  cidr_block = "10.0.1.0/24"
}

module "networking" {
  source = "./modules/networking"

  cidr_block_vpc    = "10.0.0.0/16"
  public_subnet     = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"

}

module "security" {
  source = "./modules/security"

  vpc_id = module.networking.vpc_id

}

module "iam_role_ec2" {
  source = "./modules/iam_role_ec2"

  role_name = "ec2_role"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
  ]

}

module "ec2" {
  source = "./modules/ec2"

  ami                      = "ami-0d8ec96c89ad62005"
  instance_type            = "t2.micro"
  ec2_subnet_id            = module.networking.public_subnet_id
  security_group_id        = module.security.security_group_id
  ec2_user_data            = "./modules/ec2-user-data.sh"
  eip_domain               = "vpc"
  eip_name                 = "nodejs-web-eip"
  ec2_iam_instance_profile = module.iam_role_ec2.instance_profile_name
  tag_role                 = "nodejs-deploy"
  tag_name                 = "nodejs-server-1"

}

module "s3_bucket" {
  source = "./modules/s3_bucket"

  tag_s3_name        = "My bucket"
  tag_s3_environment = "Dev"

}

module "sns" {
  source = "./modules/sns"

  sns_name       = "nodejs-notifications"
  sns_alert_name = "ec2-monitoring-alerts"

}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  cloudwatch_instance_id       = module.ec2.ec2_instance_id
  cloudwatch_alarm_actions     = module.sns.alerts_action
  metric_threshold             = 70
  log_retention_period         = 7
  cloudwatch_log_path          = "/ec2/app/logs"
  alarm_name                   = "HighCPUUtilization"
  comparison_operator          = "GreaterThanThreshold"
  metric_name                  = "CPUUtilization"
  cloudwatch_evaluation_period = 2
  namespace                    = "AWS/EC2"
  metric_period                = 120
  metric_statistic             = "Average"


}



module "codebuild" {
  source = "./modules/codebuild"


  codebuild_timeout          = 5
  codebuild_artifact         = "CODEPIPELINE"
  codebuild_compute_type     = "BUILD_GENERAL1_SMALL"
  codebuild_image            = "aws/codebuild/standard:6.0"
  codebuild_container_type   = "LINUX_CONTAINER"
  codebuild_credential_type  = "CODEBUILD"
  codebuild_source_type      = "CODEPIPELINE"
  codebuild_source_buildspec = "./buildspec.yml"
  codebuild_environment_tag  = "production"
  codebuild_project_tag      = "ci-cd-demo"
}


module "codedeploy" {
  source = "./modules/codedeploy"

  codedeploy_trigger_target_arn     = module.sns.sns_arn
  codedeploy_compute_platform       = "Server"
  codedeploy_deployment_group_name  = "nodejs-deployment-group"
  codedeploy_deployment_config_name = "CodeDeployDefault.AllAtOnce"
  codedeploy_ec2_tag_key            = "role"
  codedeploy_ec2_tag_type           = "KEY_AND_VALUE"
  codedeploy_ec2_tag_value          = "nodejs-deploy"
  codedeploy_start_event            = "DeploymentStart"
  codedeploy_success_event          = "DeploymentSuccess"
  codedeploy_failure_event          = "DeploymentFailure"
  codedeploy_auto_rollback_failure  = "DEPLOYMENT_FAILURE"
  codedeploy_trigger_name           = "notify-on-deploy"
  codedeploy_role_name              = "codedeploy_role"
  codedeploy_service_role_name      = "codedeploy_service_role"
  codedeploy_policy_name            = "codedeploy_policy"

}


module "codepipeline" {
  source = "./modules/codepipeline"

  codepipeline_source_name             = "Source"
  codepipeline_stage_source            = "Source"
  codepipeline_category_source         = "Source"
  codepipeline_source_owner            = "AWS"
  codepipeline_source_provider         = "CodeStarSourceConnection"
  codepipeline_version                 = 1
  codepipeline_source_output_artifacts = "source_output"
  codepipeline_repository              = "astrogazer22/cicd-codepipeline-terraform"
  codepipeline_branch_name             = "main"
  codepipeline_build_name              = "Build"
  codepipeline_build_stage             = "Build"
  codepipeline_category_build          = "Build"
  codepipeline_build_owner             = "AWS"
  codepipeline_build_provider          = "CodeBuild"
  codepipeline_build_output_artifacts  = "build_output"
  codepipeline_build_input_artifacts   = "source_output"
  codepipeline_deploy_name             = "Deploy"
  codepipeline_deploy_stage            = "Deploy"
  codepipeline_category_deploy         = "Deploy"
  codepipeline_deploy_owner            = "AWS"
  codepipeline_deploy_provider         = "CodeDeploy"
  codepipeline_deploy_input_artifacts  = "build_output"
  aws_connection_name                  = "github_connection"
  aws_connection_provider_type         = "GitHub"
  codepipeline_project_name            = module.codebuild.codebuild_nodejs_app_build_name
  codepipeline_application_name        = module.codedeploy.codedeploy_nodejs_app_name
  codepipeline_deployment_group        = module.codedeploy.codedeploy_deployment_group_name
  codepipeline_artifact_location       = module.s3_bucket.s3_bucket_id

}








