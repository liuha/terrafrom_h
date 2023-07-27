# Copyright (c) HashiCorp, Inc.

variable "tfc_organization" {
  type = string
}

variable "tfc_workspace" {
  type    = string
  default = "hashicat-aws"
}

variable "tfc_workspace_tags" {
  type    = list(any)
  default = ["hashicat", "azure"]
}

variable "instruqt_azure_arm_client_id" {
  type      = string
  sensitive = true
}

variable "instruqt_azure_arm_client_secret" {
  type      = string
  sensitive = true
}

variable "instruqt_azure_arm_subscription_id" {
  type      = string
  sensitive = true
}

variable "instruqt_azure_arm_tenant_id" {
  type      = string
  sensitive = true
}

variable "prefix" {
  type = string
}

variable "location" {
  type = string
}
