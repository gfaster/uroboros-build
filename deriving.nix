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
  version = "0.8.1";

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

  src = fetchFromGitHub {
    owner = "ocsigen";
    repo = pname;
    rev = version;
    sha256 = "sha256-CX5CKZrLb3dU1f5bObsXVt8ZTo71n0TjXc3L25bPfw8=";
  };
}
