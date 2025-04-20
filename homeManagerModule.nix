{emulators, ...}: let
  # Import the Home Manager configurations for each emulator
  imports =
    builtins.map
    (u: ./${u}/homeManagerModule.nix)
    emulators;
in {
  inherit imports;
}
