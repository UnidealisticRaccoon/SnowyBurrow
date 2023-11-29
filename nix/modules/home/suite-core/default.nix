# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ ezModules, ... }:
{
  imports = [
    ezModules.profile-direnv
    ezModules.profile-git
    ezModules.profile-gpg
    ezModules.profile-nix-index
    ezModules.profile-ssh
  ];
}
