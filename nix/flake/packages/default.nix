# SPDX-FileCopyrightText: 2023 Lin Yinfeng <lin.yinfeng@outlook.com>
# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ inputs, self, ... }: {
  perSystem = { system, self', pkgs, lib, ... }:
    let
      setupNixpkgs = {
        inherit system;
        config.allowUnfree = true;
      };
      setupPackages = {
        inherit inputs;
        selfLib = self.lib;
      };
    in
    {
      _module.args.pkgs = import inputs.nixpkgs setupNixpkgs;

      packages = inputs.flake-utils.lib.flattenTree (self'.legacyPackages);

      legacyPackages = self.lib.makePackages pkgs ../../pkgs setupPackages;

      checks =
        let
          pkgsStable = import inputs.nixpkgs-stable setupNixpkgs;
          pkgsLatest = import inputs.nixpkgs-latest setupNixpkgs;
        in
        inputs.flake-utils.lib.flattenTree {
          packages = lib.recurseIntoAttrs self'.legacyPackages;
          packages-stable = lib.recurseIntoAttrs (self.lib.makePackages pkgsStable ../../pkgs setupPackages);
          packages-latest = lib.recurseIntoAttrs (self.lib.makePackages pkgsLatest ../../pkgs setupPackages);
        };
    };
}
