# SPDX-FileCopyrightText: 2023 Sridhar Ratnakumar <srid@srid.ca>
# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ ezModules, flake, config, pkgs, lib, ... }:
{
  imports = [
    ezModules.git
    ezModules.gpg
    ezModules.ssh
    ezModules.direnv
    ezModules.nix-index
  ];

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  targets.genericLinux.enable = pkgs.stdenv.isLinux;

  home = {
    inherit (flake.selfLib.data) stateVersion;
    username = lib.mkDefault flake.config.people.myself;
    homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${config.home.username}";
  };
}
