# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

{ inputs, ... }: {
  imports = [
    inputs.hercules-ci-effects.flakeModule
  ];

  herculesCI.ciSystems = [ "x86_64-linux" ];
}
