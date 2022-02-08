{ pkgs ? import <nixpkgs> { } }:

let babashka-static = pkgs.callPackage (import ./babashka-static.nix) { };
in pkgs.mkShell { buildInputs = [ babashka-static ]; }
