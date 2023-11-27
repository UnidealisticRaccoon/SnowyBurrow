{ mkDerivation, base, lib, nvfetcher, text }:
mkDerivation {
  pname = "nvfetcher-main";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base nvfetcher text ];
  license = lib.licenses.mit;
  mainProgram = "main";
}
