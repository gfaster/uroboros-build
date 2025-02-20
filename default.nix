{ pkgs ? import <nixpkgs> { } }:
let 
  oldpkgs = (import (
      fetchTarball "https://github.com/NixOS/nixpkgs/archive/0f2509a52d652c9e1fe98c0673ca03572d5513ee.tar.gz"
      ) { });
  buildpkgs = (import (
      # fetchTarball "https://github.com/NixOS/nixpkgs/archive/ce90c9027482175d7bc1ff9b51088dc008a9c02c.tar.gz"
      # fetchTarball "https://github.com/NixOS/nixpkgs/archive/d93fb7b27207ae63a2e5c5b878f249a5a9fd9dd6.tar.gz"
      fetchTarball "https://github.com/NixOS/nixpkgs/archive/db8a4a4ef5644652bba98243805323eb7bf10404.tar.gz"
      ) { });
  # lc = pkgs.ocamlPackages;
  # oc = buildpkgs.ocamlPackages;
  oc = buildpkgs.ocaml-ng.ocamlPackages_4_03;
  nc = pkgs.ocaml-ng.ocamlPackages_4_03;
  # ocamlbuild requires a newer ocaml version than the rest (makes more sense as it is a tool)
  # oc_build = pkgs.ocaml-ng.ocamlPackages_4_03;
  num = if oc ? num then oc.num else nc.num;
  parmap = if oc ? parmap then oc.parmap else (pkgs.callPackage ./parmap.nix {
    ocaml = oc.ocaml;
    findlib = nc.findlib;
    ocamlbuild = nc.ocamlbuild;
  });
in 
  assert oc.ocaml.version == nc.ocaml.version;
  pkgs.callPackage ./package.nix {
    ocaml = oc.ocaml;
    findlib = nc.findlib;
    # ocamlbuild = pkgs.callPackage ./ocamlbuild.nix { ocaml = oc_build.ocaml; };
    ocamlbuild = nc.ocamlbuild;
    batteries = oc.ocaml_batteries;
    camlp4 = nc.camlp4;
    ocaml_oasis = nc.ocaml_oasis;
    inherit num;
    inherit parmap;
    deriving = pkgs.callPackage ./deriving.nix { 
      ocaml = oc.ocaml;
      findlib = nc.findlib;
      camlp4 = nc.camlp4;
      ocaml_oasis = nc.ocaml_oasis;
      ocamlbuild = nc.ocamlbuild;
      inherit num;
    };
  }
