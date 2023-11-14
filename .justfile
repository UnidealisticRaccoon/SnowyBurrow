# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

terraformdir  := 'infrastructure'

alias spd := _sops-decrypt
alias spe := _sops-encrypt
alias tfi := _terraform-init
alias tfc := _terraform-clean
alias tfs := terraform-show
alias tfp := terraform-plan
alias tfa := terraform-apply
alias tfd := terraform-destroy

[private]
default:
    @just --choose --unsorted --justfile {{justfile()}} --list-heading ''

_sops-decrypt:
    sops -d -i {{terraformdir}}/terraform.tfstate.json

_sops-encrypt:
    sops -e -i {{terraformdir}}/terraform.tfstate.json

_terraform-init: (_sops-decrypt)
    terraform -chdir={{terraformdir}} init
    terraform -chdir={{terraformdir}} validate

_terraform-clean: (_sops-encrypt)
    cd {{terraformdir}} && find -not \( -name '*.tf' -or -name 'terraform.tfstate.json' -or -name '.terraform.lock.hcl' \) -delete

# show terraform state
terraform-show: (_terraform-init) && (_terraform-clean)
    terraform -chdir={{terraformdir}} show

# plan terraform config
terraform-plan: (_terraform-init) && (_terraform-clean)
    terraform -chdir={{terraformdir}} plan

# apply terraform config
terraform-apply: (_terraform-init) && (_terraform-clean)
    terraform -chdir={{terraformdir}} apply

# destroy terraform config
terraform-destroy: (_terraform-init) && (_terraform-clean)
    terraform -chdir={{terraformdir}} destroy
