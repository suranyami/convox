terraform {
  required_version = ">= 0.12.0"
}

provider "kubernetes" {
  version = "~> 1.11"
}

resource "kubernetes_namespace" "system" {
  metadata {
    labels = {
      app    = "system"
      rack   = var.name
      system = "convox"
      type   = "rack"
    }

    name = "${var.name}-system"
  }

  timeouts {
    delete = "30m"
  }
}

resource "kubernetes_config_map" "rack" {
  metadata {
    namespace = kubernetes_namespace.system.metadata.0.name
    name      = "rack"
  }

  data = {
    DOMAIN = var.domain
  }
}
