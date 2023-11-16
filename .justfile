# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

sopsDir := 'secrets'
infraDir := 'infrastructure'
tfDir  := 'infrastructure/terraform'
tfState := sopsDir / tfDir / 'terraform.tfstate.json'

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

_hci-get-state:
    hci state get --name terraform.tfstate.json --file {{tfState}}

_hci-put-state:
    hci state put --name terraform.tfstate.json --file {{tfState}} && rm -f {{tfState}}

_sops-decrypt: (_hci-get-state)
    sops -d -i {{tfState}}

_sops-encrypt: && (_hci-put-state)
    sops -e -i {{tfState}}

_terraform-init: (_sops-decrypt)
    terraform -chdir={{tfDir}} init
    terraform -chdir={{tfDir}} validate

_terraform-clean: (_sops-encrypt)
    cd {{infraDir}} && find -type f -not \( -name '*.tf' -or -name '.terraform.lock.hcl' \) -delete

# show terraform state
terraform-show: (_terraform-init) && (_terraform-clean)
    terraform -chdir={{tfDir}} show

# plan terraform config
terraform-plan: (_terraform-init) && (_terraform-clean)
    terraform -chdir={{tfDir}} plan

# apply terraform config
terraform-apply: (_terraform-init) && (_terraform-clean)
    terraform -chdir={{tfDir}} apply

# destroy terraform config
terraform-destroy: (_terraform-init) && (_terraform-clean)
    terraform -chdir={{tfDir}} destroy
