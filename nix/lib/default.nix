# SPDX-FileCopyrightText: 2023 Lin Yinfeng <lin.yinfeng@outlook.com>
#
# SPDX-License-Identifier: MIT

{ self, inputs, config, lib, ... }:
lib.makeExtensible (selfLib: rec {
  data = lib.importJSON ./data.json;
  flattenTree = import ./flatten-tree.nix { inherit lib; };
  rakeLeaves = import ./rake-leaves.nix { inherit inputs lib; };
  buildModuleList = import ./build-module-list.nix { inherit selfLib lib; };
})
