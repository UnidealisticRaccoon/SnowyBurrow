# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
# SPDX-FileCopyrightText: Ilan Joselevich <personal@ilanjoselevich.com>
#
# SPDX-License-Identifier: MIT

{ withSystem, inputs, config, ... }: {
  imports = [
    inputs.hercules-ci-effects.flakeModule
  ];

  herculesCI = herculesCI: {
    ciSystems = [ "x86_64-linux" ];

    onPush.default.outputs.effects.terraform-deploy = withSystem config.defaultEffectSystem ({ pkgs, config, hci-effects, ... }:
      hci-effects.mkEffect {
        name = "terraform-deploy";

        inputs = with pkgs; [
          age
          sops
          gnupg
          terraform
        ];

        secretsMap.terraform-secret = "terraform-secret";

        tfstateName = "terraform.tfstate.json";

        TF_INPUT = 0;
        TF_IN_AUTOMATION = 1;

        gpg = ./GPG.pub;
        FLAKE_REF = inputs.self;

        getStateScript = ''
          mkdir -p "$PWD/infrastructure/terraform"
          mkdir -p "$PWD/secrets/infrastructure/terraform"
          export workingDir="$PWD/infrastructure/terraform"
          export secretsDir="$PWD/secrets/infrastructure/terraform"
          stateFileName="$secretsDir/$tfstateName"
          getStateFile "$tfstateName" "$stateFileName"
          readSecretString terraform-secret .ageKey > "$secretsDir/keys.txt"
        '';

        userSetupPhase = ''
          ls -lah $PWD
          cp -r $FLAKE_REF $PWD
          ls -lah $PWD
          gpg --import "$gpg"
          export SOPS_AGE_KEY_FILE=$secretsDir/keys.txt
          sops -d -i "$stateFileName"
          terraform -chdir=$workingDir init
        '';

        priorCheckScript = "terraform -chdir=$workingDir validate";

        effectScript =
          if (herculesCI.config.repo.branch == "main")
          then "terraform -chdir=$workingDir apply -auto-approve"
          else "terraform -chdir=$workingDir plan";

        putStateScript = ''
          sops -e -i "$stateFileName"
          putStateFile "$tfstateName" "$stateFileName"
          cd $workingDir && find -type f -delete
          cd $secretsDir && find -type f -delete
        '';
      }
    );
  };
}
