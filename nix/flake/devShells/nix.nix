# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ inputs, ... }:
{
  perSystem = { system, config, pkgs, lib, ... }: {
    devShells.nix = pkgs.mkShell {
      name = "nix-shell";

      packages =
        (with pkgs;[
          vulnix
          statix
          deadnix
        ]) ++ (with inputs;[
          nil.packages.${system}.default
        ]);
    };
  };
}
