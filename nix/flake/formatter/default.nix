{ inputs, ... }: {
  imports = [
    inputs.flake-root.flakeModule
    inputs.treefmt-nix.flakeModule
  ];

  perSystem = { config, ... }: {
    formatter = config.treefmt.build.wrapper;

    treefmt = {
      inherit (config.flake-root) projectRootFile;

      programs = {
        shfmt.enable = true;
        prettier.enable = true;
        shellcheck.enable = true;
        nixpkgs-fmt.enable = true;
      };
    };
  };
}
