//  Account Instance Profile 
resource "databricks_instance_profile" "shared" {
  instance_profile_arn = var.instance_profile
}

// DE + ML Cluster
data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = "Shared Autoscaling"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = "i3.xlarge"
  autotermination_minutes = 20
  autoscale {
    min_workers = 1
    max_workers = 8
  }
  aws_attributes {
    instance_profile_arn    = var.instance_profile
    availability            = "SPOT_WITH_FALLBACK"
    zone_id                 = "auto"
    first_on_demand         = 1
    spot_bid_price_percent  = 100
  }
  depends_on = [
    databricks_instance_profile.shared
  ]
}