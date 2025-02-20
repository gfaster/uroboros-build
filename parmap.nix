{ lib, 
  stdenv,
  fetchzip,
  ncurses,

  ocaml,
  findlib,
  ocamlbuild,
}:
stdenv.mkDerivation rec {
  pname = "parmap";
  version = "1.0-rc10";

  src = fetchzip {
    url = "https://github.com/rdicosmo/${pname}/archive/refs/tags/${version}.tar.gz";
    sha256 = "sha256-nIE9B599CjxcKCCcLcF2UtqVA0cVkgroEcW2rjtkPu4=";
  };

  preConfigure = ''

  if [ -z "$(ocamlfind ocamlc -version)" ]; then
    echo "no ocamlc" && false
  fi
  if [ "$(ocamlc -version)" != "$(ocamlfind ocamlc -version)" ]; then
    echo "versions don't match" && false
  fi
  '';

  buildInputs = [
    ocaml
  ];

  nativeBuildInputs = [
    ocamlbuild
    ncurses
    findlib
  ];

  propagatedBuildInputs = [
  ];

  createFindlibDestdir = true;

  doCheck = false;

}
