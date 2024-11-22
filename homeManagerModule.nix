{emulators, ...}: let
  #######################
  ## IMPORT SUBMODULES ##
  #######################
  imports =
    builtins.map
    (u: ./${u}/homeManagerModule.nix)
    emulators;
in {
  inherit imports;
}
