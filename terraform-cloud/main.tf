# Copyright (c) HashiCorp, Inc.

terraform {
  required_providers {
    tfe = {
      version = "~> 0.38.0"
    }
  }
}

/**** **** **** **** **** **** **** **** **** **** **** ****
Obtain name of the target organization from the particpant.
**** **** **** **** **** **** **** **** **** **** **** ****/

data "tfe_organization" "org" {
  name = var.tfc_organization
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 
 * DEPRECATED *
 
 Configure workspace with local execution mode so that plans 
 and applies occur on this workstation. And, Terraform Cloud 
 is only used to store and synchronize state. 

 * DEPRECATED *

**** **** **** **** **** **** **** **** **** **** **** ****/

# resource "tfe_workspace" "hashicat" {
#   name           = var.tfc_workspace
#   organization   = data.tfe_organization.org.name
#   tag_names      = var.tfc_workspace_tags
#   execution_mode = "local"
# }

/**** **** **** **** **** **** **** **** **** **** **** ****
 Configure workspace with REMOTE execution mode so that plans 
 and applies occur on Terraform Cloud's infrastructure. 
 Terraform Cloud executes code and stores state. 
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_workspace" "hashicat" {
  name           = var.tfc_workspace
  organization   = data.tfe_organization.org.name
  tag_names      = var.tfc_workspace_tags
  execution_mode = "remote"
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Configure organization-wide variables with Variables sets
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_variable_set" "hashicat" {
  name         = "Cloud Credentials"
  description  = "Dedicated Principal Account for Terraform Deployments"
  organization = data.tfe_organization.org.name
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Assing the Variables set to the hashicat workspace
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_workspace_variable_set" "hashicat" {
  variable_set_id = tfe_variable_set.hashicat.id
  workspace_id    = tfe_workspace.hashicat.id
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Add ARM_CLIENT_ID to the Cloud Credentials variable set
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_variable" "azure_arm_client_id" {
  key             = "ARM_CLIENT_ID"
  value           = var.instruqt_azure_arm_client_id
  category        = "env"
  description     = "Azure Client ID"
  variable_set_id = tfe_variable_set.hashicat.id
  sensitive       = true
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Add ARM_CLIENT_SECRET to the Cloud Credentials variable set
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_variable" "azure_arm_client_secret" {
  key             = "ARM_CLIENT_SECRET"
  value           = var.instruqt_azure_arm_client_secret
  category        = "env"
  description     = "Azure Client Secret"
  variable_set_id = tfe_variable_set.hashicat.id
  sensitive       = true
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Add ARM_SUBSCRIPTION_ID to the Cloud Credentials variable set
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_variable" "azure_arm_subscription_id" {
  key             = "ARM_SUBSCRIPTION_ID"
  value           = var.instruqt_azure_arm_subscription_id
  category        = "env"
  description     = "Azure Subscription ID"
  variable_set_id = tfe_variable_set.hashicat.id
  sensitive       = true
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Add ARM_TENANT_ID to the Cloud Credentials variable set
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_variable" "azure_arm_tenant_id" {
  key             = "ARM_TENANT_ID"
  value           = var.instruqt_azure_arm_tenant_id
  category        = "env"
  description     = "Azure Tenant ID"
  variable_set_id = tfe_variable_set.hashicat.id
  sensitive       = true
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Add PREFIX to the hashicat workspace variables
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_variable" "prefix" {
  key          = "prefix"
  value        = var.prefix
  category     = "terraform"
  description  = "Hashicat deployment prefix"
  workspace_id = tfe_workspace.hashicat.id
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Add LOCATION to the hashicat workspace variables
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_variable" "location" {
  key          = "location"
  value        = var.location
  category     = "terraform"
  description  = "Cloud location"
  workspace_id = tfe_workspace.hashicat.id
}
