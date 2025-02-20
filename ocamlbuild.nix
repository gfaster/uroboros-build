{stdenv, fetchFromGitHub, ocaml, findlib}:
let
  version = "0.9.3";
in
stdenv.mkDerivation {
  name = "ocamlbuild";
  inherit version;

  src = fetchFromGitHub {
    owner = "ocaml";
    repo = "ocamlbuild";
    rev = version;
    hash = "sha256-IyZjfWQMV1q+n3gLEe/4i69Ubqmat7xX3eVL0mkodcY=";
  };

  buildInputs = [ ocaml ];
  nativeBuildInputs = [ findlib ];

  createFindlibDestdir = true;

  configurePhase = ''
  test -n "$OCAMLFIND_DESTDIR"
  make -f configure.make Makefile.config \
    "OCAMLBUILD_PREFIX=$out" \
    "OCAMLBUILD_BINDIR=$out/bin" \
    "OCAMLBUILD_LIBDIR=$OCAMLFIND_DESTDIR"
  '';

  # configurePhase = "ocaml setup.ml -configure --prefix $out";
  # buildPhase     = "ocaml setup.ml -build";
  # installPhase   = "ocaml setup.ml -install";
}
