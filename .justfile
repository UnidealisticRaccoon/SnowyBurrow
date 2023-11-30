# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
# SPDX-FileCopyrightText: 2023 Sridhar Ratnakumar <srid@srid.ca>
#
# SPDX-License-Identifier: MIT

infraDir := 'infrastructure'
tfDir  := 'infrastructure/terraform'

export GOOGLE_BACKEND_CREDENTIALS := if `echo $USER` == 'vscode' {
  ``
} else {
  `sops -d secrets/infrastructure/terraform/google.json | tr -s '\n' ' '`
}

alias tfi := _terraform-init
alias tfc := _terraform-clean
alias tfs := terraform-show
alias tfp := terraform-plan
alias tfa := terraform-apply
alias tfd := terraform-destroy
alias tfr := terraform-refresh
alias tfo := terraform-outputs
alias nvf := nvfetcher-update
alias nxf := nix-fmt
alias nxch := nix-check
alias nxi := nix-io
alias nxu := nix-update
alias nxd := nix-dev
alias nxbh := nix-build-home
alias nxsh := nix-switch-home
alias nxcl := nix-clean

[private]
default:
    @just --choose --unsorted --justfile {{justfile()}} --list-heading ''

_terraform-init:
    terraform -chdir={{tfDir}} fmt
    terraform -chdir={{tfDir}} init
    terraform -chdir={{tfDir}} validate

_terraform-clean:
    rm -rf {{tfDir}}/.terraform

# show terraform state
terraform-show *args: (_terraform-init) && (_terraform-clean)
    terraform -chdir={{tfDir}} show {{args}}

# plan terraform config
terraform-plan *args: (_terraform-init) && (_terraform-clean)
    terraform -chdir={{tfDir}} plan {{args}}

# apply terraform config
terraform-apply: (_terraform-init) && (_terraform-clean)
    terraform -chdir={{tfDir}} apply -auto-approve

# destroy terraform config
terraform-destroy *args: (_terraform-init) && (_terraform-clean)
    terraform -chdir={{tfDir}} destroy {{args}}

# refresh terraform state
terraform-refresh: (_terraform-init) && (_terraform-clean)
    terraform -chdir={{tfDir}} refresh

# show terraform outputs
terraform-outputs: (_terraform-init) && (_terraform-clean)
    terraform -chdir={{tfDir}} output

# update packages with nvfetcher
nvfetcher-update:
    nix run .#devPackages/nvfetcher-self -- -o nix/pkgs/_sources

# fmt files
nix-fmt:
  nix fmt

# check flake
nix-check: (nix-fmt)
  nix flake check

# print inputs and outputs
nix-io:
  nix flake metadata
  nix flake show

# update nix flake
nix-update:
  nix flake update

# enter devshell
nix-dev:
  nix develop

# build home-manager activation package
nix-build-home *home:
  nix build .#homeConfigurations.{{home}}.activationPackage

# activate home-manager profile
nix-switch-home *home:
  nix run .#homeConfigurations.{{home}}.activationPackage

# remove build outputs
nix-clean:
  rm -f ./result
