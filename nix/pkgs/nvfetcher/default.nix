{ lib, newScope, selfPackages, selfLib }:

lib.makeScope newScope (self:
let
  inherit (self) callPackage;
in
{
  main = callPackage ./main { };
  changes = callPackage ./changes { };
  commit = callPackage ./commit { };
  update = callPackage ./update {
    inherit selfLib selfPackages;
  };
})
