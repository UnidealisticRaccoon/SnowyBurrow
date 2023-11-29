# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ config, lib, ... }:
{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      ${lib.optionalString config.services.gpg-agent.enable "IdentityAgent /run/user/1000/gnupg/S.gpg-agent.ssh \n"}
    '';
  };
}
