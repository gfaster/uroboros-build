{
  fetchFromGitHub,
  stdenv,
  lib,
  python3,
  pkg-config,
  m4,
  ncurses,
  callPackage,


  ocaml,
  findlib,
  ocamlbuild,
  parmap,
  batteries,
  camlp4,
  ocaml_oasis,
  num,
  deriving,
}:
stdenv.mkDerivation rec {
  pname = "uroboros";
  version = "0.5";

  src = fetchFromGitHub {
    owner = "s3team";
    repo = pname;
    # rev = "v${version}";
    # sha256 = "sha256-g4y2fExaOjMJogG8x8K/U3tRy1BZJ8ddZXbi+nc9cYA=";
    rev = "3dbdf14abc3f518684d29c8e34de358200a6766e";
    hash = "sha256-1CoK5XdMKZWlt5q6El418DtZIAAcUNB4vswH7Trtmhw=";
  };

  nativeBuildInputs = [
    ncurses
    findlib
    ocaml_oasis
    ocamlbuild
  ];

  buildInputs = [
    ocaml
    parmap
    batteries
    deriving
  ];

  skipConfigure = true;

  buildPhase = ''
    ocamlfind list
    cd src
    ocamlbuild -use-ocamlfind \
      type.native \
      -ocamlopt "-inline 20" -ocamlopt -nodynlink

      parser.native \
      ail_parser.native \
      ail.native \
      visit.native \
      init.native \
      pp_print.native \
      cfg.native \
      ail_utils.native \
      cg.native \
      func_slicer.native \
      disassemble_validator.native \
      lex_new.native \
      reassemble_symbol_get.native \
      data_process.native \
      share_lib_helper.native \
      disassemble_process.native \
      analysis_process.native \
      instrumentation_plugin.native \
  '';

  installPhase = ''
    echo "TODO" && false
  '';

}
