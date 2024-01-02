# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ ezModules, ... }:
{
  imports = [
    ezModules.profile-kitty
  ];

  xsession.enable = true;
}
