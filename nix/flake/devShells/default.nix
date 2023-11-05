# SPDX-FileCopyrightText: 2023 Lin Yinfeng <lin.yinfeng@outlook.com>
# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ ... }: {
  perSystem = { self', config, pkgs, lib, ... }: {
    checks = lib.mapAttrs' (name: drv: lib.nameValuePair "devShells/${name}" drv) self'.devShells;

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
      ];
    };
  };
}
