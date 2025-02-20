{
  fetchFromGitHub,
  stdenv,
  lib,
  ncurses,

  ocaml,
  findlib,
  camlp4,
  ocaml_oasis,
  ocamlbuild,
  num
}:
stdenv.mkDerivation rec {
  pname = "deriving";
  version = "0.7";

  src = fetchFromGitHub {
    owner = "ocsigen";
    repo = pname;
    rev = version;
    hash = "sha256-fEnxoehQrw/+jlVEZJF5T6s/HnV1dJGEVT4GT58B5hc=";
  };

  patches = [ ./deriving_lt402.patch ];

  buildInputs = [
    ocamlbuild
    ocaml
  ];

  nativeBuildInputs = [
    ncurses
    findlib
    ocaml_oasis
  ];

  propagatedBuildInputs = [
    camlp4
    num
  ];

  preConfigure = ''
    echo "deriving packages list "
    ocamlfind list
  '';

  createFindlibDestdir = true;
  # preBuild = ''
  #   mkdir -p "$out/lib/ocaml/${ocaml.version}/site-lib"
  # '';

}
