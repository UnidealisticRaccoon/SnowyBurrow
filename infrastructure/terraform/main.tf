# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

terraform {
  required_version = "~> 1.6"

  backend "local" {
    path = "../../secrets/infrastructure/terraform/terraform.tfstate.json"
  }
}
