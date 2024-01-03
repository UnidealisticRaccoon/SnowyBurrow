# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ ezModules, pkgs, ... }:
{
  imports = [
    ezModules.suite-desktop
    ezModules.profile-fish
  ];

  home.packages = with pkgs; [
    typst
    taplo
    marksman
    asciinema
  ];
}
