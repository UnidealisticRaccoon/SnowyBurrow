# SPDX-FileCopyrightText: 2023 Lin Yinfeng <lin.yinfeng@outlook.com>
# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ inputs, ... }: {
  perSystem = { system, self', pkgs, lib, ... }:
    let
      config.allowUnfree = true;
    in
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system config;
      };
    };
}
