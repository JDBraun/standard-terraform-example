locals {
  account_id                   = var.aws_account_id
  prefix                       = var.resource_prefix
  owner                        = var.resource_owner
  vpc_cidr_range               = var.vpc_cidr_range
  private_subnets_cidr         = split(",", var.private_subnets_cidr)
  public_subnets_cidr          = split(",", var.public_subnets_cidr)
  privatelink_subnets_cidr     = split(",", var.privatelink_subnets_cidr)
  sg_egress_ports              = [443, 3306, 6666]
  sg_ingress_protocol          = ["tcp", "udp"]
  sg_egress_protocol           = ["tcp", "udp"]
  availability_zones           = split(",", var.availability_zones)
  dbfsname                     = join("", [local.prefix, "-", var.region, "-", "dbfsroot"]) 
  ucname                       = join("", [local.prefix, "-", var.region, "-", "uc"]) 
}

// Create External Databricks Workspace
module "databricks_mws_workspace" {
  source = "./modules/databricks_workspace"
  providers = {
    databricks = databricks.mws
  }

  databricks_account_id        = var.databricks_account_id
  resource_prefix              = local.prefix
  security_group_ids           = [aws_security_group.sg.id]
  subnet_ids                   = aws_subnet.private[*].id
  vpc_id                       = aws_vpc.dataplane_vpc.id
  cross_account_role_arn       = aws_iam_role.cross_account_role.arn
  bucket_name                  = aws_s3_bucket.root_storage_bucket.id
  region                       = var.region
  backend_rest                 = aws_vpc_endpoint.backend_rest.id
  backend_relay                = aws_vpc_endpoint.backend_relay.id
}

// Create Unity Catalog
module "databricks_uc" {
    source = "./modules/unity_catalog"
    providers = {
      databricks = databricks.created_workspace
    }
  
  resource_prefix                 = local.prefix
  databricks_workspace            = module.databricks_mws_workspace.workspace_id
  uc_s3                           = aws_s3_bucket.unity_catalog_bucket.id
  uc_iam_arn                      = aws_iam_role.unity_catalog_role.arn
  uc_iam_name                     = aws_iam_role.unity_catalog_role.name
  data_bucket                     = var.data_bucket
  storage_credential_role_name    = aws_iam_role.storage_credential_role.name
  storage_credential_role_arn     = aws_iam_role.storage_credential_role.arn
  depends_on = [module.databricks_mws_workspace]
}

// Create Create Cluster & Instance Profile
module "cluster_configuration" {
    source = "./modules/cluster_configuration"
    providers = {
      databricks = databricks.created_workspace
    }
  
  instance_profile = aws_iam_instance_profile.s3_instance_profile.arn
  depends_on = [module.databricks_mws_workspace]
}