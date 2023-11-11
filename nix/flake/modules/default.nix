# SPDX-FileCopyrightText: 2023 Lin Yinfeng <lin.yinfeng@outlook.com>
# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ lib, ... }:
{
  imports = lib.attrValues (import ../../modules/flake);

  flake.flakeModules = import ../../modules/flake;
}
