{ inputs, ... }: {
  imports = [
    inputs.flat-flake.flakeModules.flatFlake
  ];
}
