locals {
  resource_name = "${var.prefix}-${var.project}-${var.environment}"
  config = {

    plata = {
      instance_class                        = contains(["db.t3.medium", "db.t3.large", "db.t3.xlarge", "db.t3.2xlarge", "db.m5.large", "db.m5.xlarge", "db.m5.2xlarge"], var.instance_class) ? var.instance_class : null
      maintenance_window                    = "mon:18:00-mon:20:00"
      backup_window                         = "17:00-18:00"
      monitoring_interval                   = 0
      performance_insights_enabled          = false
      performance_insights_retention_period = var.db_type == "aurora" ? null : 0
      multi_az                              = false
      cluster_log_retention_in_days         = 30
      stream_view_type                      = "KEYS_ONLY"
      write_capacity                        = 0
      read_capacity                         = 0
      node_groups = {
        default = {
          desired_capacity = 2
          max_capacity     = 5
          min_capacity     = 2

          instance_types = ["t3.medium"]
          capacity_type  = "ON_DEMAND"
        }
      }

    }

    oro = {
      instance_class                        = contains(["db.r5.large", "db.r5.xlarge", "db.r5.2xlarge", "db.r5.4xlarge", "db.r5.8xlarge", "db.m5.large", "db.m5.xlarge", "db.m5.2xlarge", "db.m5.4xlarge", "db.m5.8xlarge"], var.instance_class) ? var.instance_class : null
      maintenance_window                    = "mon:02:00-mon:04:00"
      backup_window                         = "00:00-02:00"
      monitoring_interval                   = 30
      performance_insights_enabled          = true
      performance_insights_retention_period = 7
      multi_az                              = true
      cluster_log_retention_in_days         = 90
      stream_view_type                      = "NEW_AND_OLD_IMAGES"
      write_capacity                        = 5
      read_capacity                         = 5
      node_groups = {
        default = {
          desired_capacity = 2
          max_capacity     = 10
          min_capacity     = 2

          instance_types = ["t3.medium"]
          capacity_type  = "ON_DEMAND"
        }
      }
    }

    platino = {
      instance_class                        = contains(["db.r5.large", "db.r5.xlarge", "db.r5.2xlarge", "db.r5.4xlarge", "db.r5.8xlarge", "db.m5.large", "db.m5.xlarge", "db.m5.2xlarge", "db.m5.4xlarge", "db.m5.8xlarge"], var.instance_class) ? var.instance_class : null
      maintenance_window                    = "mon:02:00-mon:04:00"
      backup_window                         = "00:00-02:00"
      monitoring_interval                   = 30
      performance_insights_enabled          = true
      performance_insights_retention_period = 7
      cluster_log_retention_in_days         = 90
      stream_view_type                      = "NEW_AND_OLD_IMAGES"
      write_capacity                        = 5
      read_capacity                         = 5

      node_groups = {
        default = {
          desired_capacity = 2
          max_capacity     = 10
          min_capacity     = 2

          instance_types = ["t3.medium"]
          capacity_type  = "ON_DEMAND"
        }
      }
    }
    oracle = {
      parameters = [
        {
          name  = "archive_lag_target"
          value = "300"
        },
        {
          name  = "db_block_checking"
          value = "MEDIUM"
        },
        {
          name  = "job_queue_processes"
          value = "50"
        },
        {
          name  = "open_cursors"
          value = "300"
        },
        {
          name  = "recyclebin"
          value = "OFF"
        },
        {
          name  = "sqlnetora.sqlnet.allowed_logon_version_client"
          value = "8"
        }
      ]
      enabled_cloudwatch_logs_exports = ["alert", "audit", "listener", "trace"]
      major_engine_version            = "19"
      timeouts                        = { "create" : "40m", "delete" : "40m", "update" : "80m" }
      restore_to_point_in_time        = null
    }

    postgre = {
      parameters = [
        {
          name  = "autovacuum_analyze_scale_factor"
          value = "0.05"
        },
        {
          name  = "autovacuum_naptime"
          value = "15"
        },
        {
          name  = "autovacuum_vacuum_scale_factor"
          value = "0.1"
        },
        {
          name  = "checkpoint_completion_target"
          value = "0.9"
        },
        {
          name  = "huge_pages"
          value = "on"
        },
        {
          name  = "idle_in_transaction_session_timeout"
          value = "86400000"
        },
        {
          name  = "jit"
          value = "0"
      }]
      enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
      major_engine_version            = "11"
      timeouts                        = { "create" : "40m", "delete" : "40m", "update" : "80m" }
      restore_to_point_in_time        = null
    }
    aurora = {
      enabled_cloudwatch_logs_exports = []
      restore_to_point_in_time        = {}
      parameters                      = []
    }
    dynamo = {
      timeouts = { "create" : "10m", "delete" : "10m", "update" : "60m" }
    }

  }

}

