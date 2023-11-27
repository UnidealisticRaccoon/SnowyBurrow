{ lib, newScope, selfPackages, selfLib }:

lib.makeScope newScope (self:
let
  inherit (self) callPackage;
in
{
  main = callPackage ./main { };
})
