
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
