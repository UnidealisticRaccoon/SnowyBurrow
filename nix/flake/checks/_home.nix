{ self, ... }:
{
  perSystem = { lib, ... }: {
    checks = lib.mapAttrs'
      (
        name: value: {
          name = "homeConfigurations/${name}";
          value = value.activationPackage;
        }
      )
      self.homeConfigurations;
  };
}
