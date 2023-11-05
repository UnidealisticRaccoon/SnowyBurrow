{ inputs, ... }: {
  imports = [
    inputs.pre-commit-hooks-nix.flakeModule
    inputs.flat-flake.flakeModules.flatFlake
  ];

  perSystem.pre-commit = {
    check.enable = true;

    settings = {
      excludes = [
        "flake.lock"
      ];

      hooks = {
        nil.enable = true;
        shfmt.enable = true;
        prettier.enable = true;
        shellcheck.enable = true;
        commitizen.enable = true;
        nixpkgs-fmt.enable = true;
      };
    };
  };
}
