{ pkgs ? import <nixpkgs> {} }:

with pkgs; haskell.lib.buildStackProject {
  name = "cis194-templates";
  shellHook = ''
    alias stack="stack --nix"
  '';
}
