# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
# SPDX-FileCopyrightText: 2023 Elizabeth Paź <me@ehllie.xyz>
#
# SPDX-License-Identifier: MIT

{ ezModules, pkgs, lib, ... }:
{
  imports = [
    ezModules.profile-bat
    ezModules.profile-direnv
    ezModules.profile-eza
    ezModules.profile-fzf
    ezModules.profile-git
    ezModules.profile-gpg
    ezModules.profile-nix-index
    ezModules.profile-ssh
    ezModules.profile-starship
    ezModules.profile-yazi
    ezModules.profile-zoxide
  ];
}
