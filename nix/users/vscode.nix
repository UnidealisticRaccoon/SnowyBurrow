# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ pkgs, lib, ... }:
{
  programs.bash.enable = true;

  home = {
    username = lib.mkForce "vscode";
    packages = with pkgs; [
      nil # nix LSP
    ];
  };
}
