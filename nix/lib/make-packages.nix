# SPDX-FileCopyrightText: 2023 Lin Yinfeng <lin.yinfeng@outlook.com>
#
# SPDX-License-Identifier: MIT

{ lib }:
let
  isSupportedUnderSystem = sys: p:
    if p.meta ? platforms
    then lib.elem sys p.meta.platforms
    else true;

  filterPackage = system: p:
    !(p.meta.broken or false) &&
    isSupportedUnderSystem system p;

  filter = system: t:
    if lib.isAttrs t
    then
      lib.mapAttrs (_name: v: if v.recurseForDerivations or false then filter system v else v)
        (lib.filterAttrs
          (_: p:
            !(lib.isDerivation p) ||
            filterPackage system p)
          t)
    else
      t;
in
pkgs: path: extraArgs:
filter pkgs.stdenv.hostPlatform.system
  (pkgs.callPackage path extraArgs)
