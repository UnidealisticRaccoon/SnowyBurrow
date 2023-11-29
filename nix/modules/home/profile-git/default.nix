# SPDX-FileCopyrightText: 2023 Sridhar Ratnakumar <srid@srid.ca>
# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ flake, pkgs, ... }:
{
  home.shellAliases.g = "git";

  programs.git = {
    enable = true;
    lfs.enable = true;
    package = pkgs.gitAndTools.gitFull;
    extraConfig = {
      pull.rebase = true;
      commit.gpgsign = true;
      rebase.autostash = true; # https://stackoverflow.com/a/30209750/22859493
      init.defaultBranch = "main";
      diff.sopsdiffer.textconv = "${pkgs.sops}/bin/sops -d --config /dev/null";
      user = with flake.config.people; {
        name = users.${myself}.name;
        email = users.${myself}.email;
        signingkey = users.${myself}.keys.gpg;
      };
      alias = {
        co = "checkout";
        ci = "commit";
        cia = "commit --amend";
        st = "status";
        sw = "switch";
        b = "branch";
        ps = "push";
        pl = "pull";
      };
    };
  };
}
