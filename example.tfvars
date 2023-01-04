// Databricks Variables
databricks_account_username = ""
databricks_account_password = ""
databricks_account_id = ""
resource_owner = ""
resource_prefix = "standard-terraform-example"

// AWS Variables
aws_access_key = ""
aws_secret_key = ""
aws_account_id = ""
data_bucket = ""

// Dataplane Variables
region = "us-east-1"
vpc_cidr_range = "10.0.0.0/18"
private_subnets_cidr = "10.0.32.0/22,10.0.36.0/22"
public_subnets_cidr = "10.0.40.0/22,10.0.44.0/22"
privatelink_subnets_cidr = "10.0.56.0/22"
availability_zones = "us-east-1a,us-east-1b"

// Regional Private Link Variables: https://docs.databricks.com/administration-guide/cloud-configurations/aws/privatelink.html#regional-endpoint-reference
relay_vpce_service = ""
workspace_vpce_service = ""
