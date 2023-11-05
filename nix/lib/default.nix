# SPDX-FileCopyrightText: 2023 Lin Yinfeng <lin.yinfeng@outlook.com>
#
# SPDX-License-Identifier: MIT

{ inputs, lib }:
lib.makeExtensible (self: {
  flattenTree = import ./flatten-tree.nix { inherit lib; };
  rakeLeaves = import ./rake-leaves.nix { inherit inputs lib; };
  buildModuleList = import ./build-module-list.nix { inherit self lib; };
})
