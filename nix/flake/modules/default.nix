# SPDX-FileCopyrightText: 2023 Lin Yinfeng <lin.yinfeng@outlook.com>
# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
# SPDX-FileCopyrightText: 2023 Elizabeth Paź <me@ehllie.xyz>
#
# SPDX-License-Identifier: MIT

{ self, inputs, lib, ... }:
{
  imports = [
    inputs.ez-configs.flakeModule
  ] ++ lib.attrValues (import ../../modules/flake);

  flake.flakeModules = import ../../modules/flake;

  ezConfigs = {
    inherit (self.lib) globalArgs;

    root = ./.;
    nixos = {
      modulesDirectory = ../../modules/nixos;
      configurationsDirectory = ../../hosts/nixos;
    };
    darwin = {
      modulesDirectory = ../../modules/darwin;
      configurationsDirectory = ../../hosts/darwin;
    };
    home = {
      modulesDirectory = ../../modules/home;
      configurationsDirectory = ../../users;
      users = {
        vscode = {
          standalone = {
            enable = true;
            pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
          };
        };
      };
    };
  };
}
