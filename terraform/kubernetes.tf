resource "kubernetes_secret" "cloudsql_db_credentials" {
  depends_on = ["google_container_cluster.hexlet_basics"]

  "metadata" {
    name = "cloudsql-db-credentials"
  }

  data {
    DB_USERNAME = "${var.db_username}"
    DB_PASSWORD = "${var.db_password}"
  }
}

resource "kubernetes_secret" "cloudsql_instance_credentials" {
  depends_on = ["google_container_cluster.hexlet_basics"]

  metadata {
    name = "cloudsql-instance-credentials"
  }

  data {
    credentials.json = "${base64decode(google_service_account_key.cloudsql_proxy.private_key)}"
  }
}

resource "kubernetes_secret" "cloudflare_credentials" {
  depends_on = ["google_container_cluster.hexlet_basics"]

  metadata {
    name = "cloudflare-credentials"
  }

  data {
    api_key = "${var.cloudflare_api_key}"
    email   = "${var.cloudflare_email}"
  }
}

resource "kubernetes_secret" "github_credentials" {
  depends_on = ["google_container_cluster.hexlet_basics"]

  metadata {
    name = "github-credentials"
  }

  data {
    GITHUB_CLIENT_ID_RU = "${var.github_client_id}"
    GITHUB_CLIENT_SECRET_RU = "${var.github_client_secret}"
  }
}

resource "kubernetes_secret" "hexlet_basics_secrets" {
  depends_on = ["google_container_cluster.hexlet_basics"]

  metadata {
    name = "hexlet-basics-secrets"
  }

  data {
    SECRET_KEY_BASE = "${var.secret_key_base}"
    ROLLBAR_ACCESS_TOKEN = "${var.rollbar_access_token}"
  }
}

resource "kubernetes_config_map" "hexlet_basics_config_map" {
  metadata {
    name = "hexlet-basics-config-map"
  }

  data {
    MIX_ENV = "prod"
    PORT  = "4000"
    NODE_ENV  = "production"
    DB_HOSTNAME  = "sql-proxy-service"
    DB_POOL_SIZE  = "10"
    DB_NAME  = "hexlet_basics_prod"
    FORCE  = "11"
  }
}

