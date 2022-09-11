terraform {
  required_version = ">=1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.20.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "remote-state"
    storage_account_name = "remotestatecabral"
    container_name       = "remote-state"
    key                  = "azure-vm/terraform.tfstate"
  }
}


provider "azurerm" {
  features {}
}

### TFSTATE ONDE ESTAMOS BUSCANDO INFORMAÇÕES PARA POPULAR UMA PROPRIEDADE NO BLOCO azurerm_network_interface.network_interface
data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "remote-state"
    storage_account_name = "remotestatecabral"
    container_name       = "remote-state"
    key                  = "pipeline-gitlab-ci/terraform.tfstate"
  }
}


provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      owner      = "Sergio Cabral"
      managed-by = "terraform"
    }
  }
}

### REMOTE STATE ONDE ESTAMOS BUSCANDO DADOS PARA POPULAR O BLOCO AWS_INSTANCE.VM 
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "cabral-remote-state"
    key    = "aws-pc/terraform.tfstate"
    region = "us-east-1"
  }
}