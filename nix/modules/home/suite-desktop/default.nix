# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ ezModules, ... }:
{
  imports = [
    ezModules.profile-kitty
    ezModules.profile-chrome
  ];

  xsession.enable = true;
}
