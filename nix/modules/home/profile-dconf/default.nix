# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
# SPDX-FileCopyrightText: 2023 jamesAtIntegratnIO <james@integratn.io>
# SPDX-FileCopyrightText: 2023 Ana Hobden <operator@hoverbear.org>
#
# SPDX-License-Identifier: MIT
# SPDX-License-Identifier: Apache-2.0

{ flake, config, pkgs, ... }:
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

    "org/gnome/desktop/background" =
      let
        wallpaper = flake.self.packages.${pkgs.system}."wallpapers/default".override {
          wallpaperFill = "#1e1e2e";
          wallpaperColorize = "75%";
          wallpaperParams = "-10,0";
        };
      in
      {
        picture-options = "zoom";
        color-shading-type = "solid";
        picture-uri = "file://${wallpaper}/original.png";
        picture-uri-dark = "file://${wallpaper}/dimmed.png";
      };
  };
}
