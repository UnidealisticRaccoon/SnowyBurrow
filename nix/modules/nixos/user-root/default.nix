# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ flake, ... }:
{
  users.users.root = {
    initialHashedPassword = null;
    openssh.authorizedKeys.keys = [
      "${flake.config.people.users.${flake.config.people.myself}.keys.ssh}"
    ];
  };
}
