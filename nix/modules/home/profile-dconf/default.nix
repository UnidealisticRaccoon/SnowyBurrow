# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
# SPDX-FileCopyrightText: 2023 jamesAtIntegratnIO <james@integratn.io>
#
# SPDX-License-Identifier: MIT

{ config, pkgs, ... }:
let
  gnomeExtensions = with pkgs.gnomeExtensions; [
    pano
    unmess
    caffeine
    gsconnect
    mpris-label
    user-themes
    appindicator
    tailscale-qs
  ];
in
{
  home.packages = gnomeExtensions;

  dconf.settings = {
    # Extensions
    "org/gnome/shell" = {
      disabled-extensions = [ ];
      enabled-extensions =
        (map (extension: extension.extensionUuid) gnomeExtensions) ++ [
          "light-style@gnome-shell-extensions.gcampax.github.com"
          "places-menu@gnome-shell-extensions.gcampax.github.com"
        ];
    };
    "org/gnome/shell/extensions/user-theme".name = config.gtk.theme.name;
  };
}
