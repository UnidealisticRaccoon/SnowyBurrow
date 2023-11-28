# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ config, lib, ... }:
{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      IdentityAgent /run/user/1000/gnupg/S.gpg-agent.ssh
    '';
  };
}
