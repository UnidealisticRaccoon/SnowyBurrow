{
  description = "Personal Nix Config: powered by flake-parts";

  nixConfig = {
    extra-substituters = [
      "https://cache.garnix.io"
      "https://procyon.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "procyon.cachix.org-1:VljSnjtMCpriTsvji4EotHS9UZJoPMOCVk//fmmvIto="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      # https://github.com/hercules-ci/flake-parts/pull/162#issuecomment-1570753296
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # flake modules
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flat-flake = {
      url = "github:linyinfeng/flat-flake";
      inputs.crane.follows = "crane";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
      inputs.flake-utils.follows = "flake-utils";
      inputs.flake-parts.follows = "flake-parts";
      inputs.treefmt-nix.follows = "treefmt-nix";
      inputs.rust-overlay.follows = "rust-overlay";
      inputs.flake-compat.follows = "flake-compat";
    };

    # libraries
    systems.url = "github:nix-systems/default";
    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # compatibility layer
    flake-compat = {
      flake = false;
      url = "github:edolstra/flake-compat";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ self, lib, ... }:
      let
        selfLib = import ./nix/lib { inherit inputs lib; };
      in
      {
        flake.lib = selfLib;

        imports = selfLib.buildModuleList ./nix/flake;

      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      });
}
