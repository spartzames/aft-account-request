provider "aws" {
  profile = "default"
  region = var.ct_home_region
}

variable "ct_home_region" {
  description = "The region from which this module will be executed. This MUST be the same region as Control Tower is deployed."
  type        = string
  validation {
    condition     = can(regex("(us(-gov)?|ap|ca|cn|eu|sa|me|af)-(central|(north|south)?(east|west)?)-\\d", var.ct_home_region))
    error_message = "Variable var: region is not valid."
  }
}

module "req_accnt_dev01" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail = "spartzames.koreanair+ctws-aftdev1@gmail.com"
    AccountName  = "aftdev1"
    # Syntax for top-level OU
    ManagedOrganizationalUnit = "Production"
    # Syntax for nested OU
    # ManagedOrganizationalUnit = "Sandbox (ou-xfe5-a8hb8ml8)"
    SSOUserEmail     = "spartzames.koreanair@gmail.com"
    SSOUserFirstName = "james"
    SSOUserLastName  = "spartz"
  }

  account_tags = {
    "ABC:Owner"       = "spartzames.koreanair@gmail.com"
    "ABC:Environment" = "Dev"
    "ABC:Project"     = "CTWS-AFT"
  }

  change_management_parameters = {
    change_requested_by = "james spartz"
    change_reason       = "Customized dev account vending with AFT"
  }

  custom_fields = {
    custom_param1 = "dev1"
  }

  account_customizations_name = "DEV2-BUDGET-2"
}