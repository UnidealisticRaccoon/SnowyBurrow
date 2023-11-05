# SPDX-FileCopyrightText: 2023 Lin Yinfeng <lin.yinfeng@outlook.com>
#
# SPDX-License-Identifier: MIT

{ self, lib }:
let
  inherit (self) flattenTree rakeLeaves;
in
dir: lib.attrValues (flattenTree (rakeLeaves dir))
