# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ config, lib, ... }:
{
  programs.ssh = {
    enable = true;
    extraConfig =
      if config.services.gpg-agent.enable then ''
        IdentityAgent /run/user/1000/gnupg/S.gpg-agent.ssh
      '' else '''';
  };
}
