# SPDX-FileCopyrightText: 2023 Lin Yinfeng <lin.yinfeng@outlook.com>
# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ inputs, ... }: {
  perSystem = { self', config, pkgs, lib, ... }:
    {
      checks = inputs.flake-utils.lib.flattenTree {
        devShells = lib.recurseIntoAttrs self'.devShells;
      };

      devShells.default = pkgs.mkShell {
        shellHook = ''
          source ${config.pre-commit.installationScript}
        '';

        inputsFrom = with config; [
          flake-root.devShell
          treefmt.build.devShell
          # FIXME: needed? https://zero-to-flakes.com/treefmt-nix/#add-treefmt-to-your-devshell
          # treefmt.build.programs
        ];

        packages = with pkgs; [
          # Legal
          reuse

          # CI
          hci

          # Infra
          terraform

          # Secrets
          age
          sops
          ssh-to-age
          ssh-to-pgp
        ];
      };
    };
}
