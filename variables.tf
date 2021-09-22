variable dockerhub_credentials{
    type = string
}

variable codestar_connector_credentials {
    type = string
}

variable "deploy_mod" {
  description = "Speicfy Module to Deploy"
  type = string
}