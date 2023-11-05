{ ... }: {
  perSystem = { self', config, pkgs, lib, ... }: {
    checks = lib.mapAttrs' (name: drv: lib.nameValuePair "devShells/${name}" drv) self'.devShells;

    devShells.default = pkgs.mkShell {
      shellHook = ''
        source ${config.pre-commit.installationScript}
      '';
    };
  };
}
