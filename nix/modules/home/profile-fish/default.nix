# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ ... }:
{
  programs.fish.interactiveShellInit = ''
    set fish_greeting
  '';
}
