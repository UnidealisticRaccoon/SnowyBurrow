# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
# SPDX-FileCopyrightText: 2023 Elizabeth Paź <me@ehllie.xyz>
#
# SPDX-License-Identifier: MIT

{ config, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    stdlib = ''
      declare -A direnv_layout_dirs
      direnv_layout_dir() {
        echo "''${direnv_layout_dirs[$PWD]:=$(
          local hash="$(sha1sum - <<<"''${PWD}" | cut -c-7)"
          local path="''${PWD//[^a-zA-Z0-9]/-}"
          echo "${config.xdg.cacheHome}/direnv/layouts/''${hash}''${path}"
        )}"
      }
    '';
  };

  home.shellAliases = {
    nixify = ''
      if [ ! -e ./.envrc ]; then
        echo "use nix" > .envrc
        direnv allow
      fi

      if [[ ! -e shell.nix ]] && [[ ! -e default.nix ]]; then
        cat > default.nix <<'EOF'
        with import <nixpkgs> {};
        mkShell {
          nativeBuildInputs = [
            bashInteractive
          ];
        }
        EOF
        ${"EDITOR:-nano"} default.nix
      fi
    '';
    flakify = ''
      if [ ! -e flake.nix ]; then
        nix flake new -t github:nix-community/nix-direnv .
      elif [ ! -e .envrc ]; then
        echo "use flake" > .envrc
        direnv allow
      fi
      ${"EDITOR:-nano"} flake.nix
    '';
  };
}
