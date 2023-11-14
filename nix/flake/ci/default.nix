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
        sops = "${inputs.self}/.sops.yaml";
        tfDir = "${inputs.self}/infrastructure";

        getStateScript = ''
          mkdir -p "$PWD/infrastructure"
          export workingDir="$PWD/infrastructure"
          stateFileName="$workingDir/$tfstateName"
          getStateFile "$tfstateName" "$stateFileName"
          readSecretString terraform-secret .ageKey > "$workingDir/keys.txt"
        '';

        userSetupPhase = ''
          gpg --import "$gpg"
          export SOPS_AGE_KEY_FILE=$workingDir/keys.txt
          cp "$sops" "$PWD/.sops.yaml"
          sops -d -i "$stateFileName"
          cp -r "$tfDir" "$PWD"
          terraform -chdir=$workingDir init
        '';

        priorCheckScript = "echo 'validating...' && terraform -chdir=$workingDir validate";

        effectScript =
          if (herculesCI.config.repo.branch == "main")
          then "terraform -chdir=$workingDir apply -auto-approve"
          else "terraform -chdir=$workingDir plan";

        putStateScript = ''
          sops -e -i "$stateFileName"
          putStateFile "$tfstateName" "$stateFileName"
          cd $workingDir && find -not \( -name '*.tf' -or -name '.terraform.lock.hcl' \) -delete
        '';
      }
    );
  };
}
