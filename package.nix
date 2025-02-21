{
  fetchFromGitHub,
  stdenv,
  lib,
  python3,
  pkg-config,
  m4,
  ncurses,
  python310,
  bintools,
  makeWrapper,
  coreutils,
  file,
  gcc,
  gawk,
  gnugrep,

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
  version = "0.5.2";

  src = fetchFromGitHub {
    owner = "s3team";
    repo = pname;
    # rev = "v${version}";
    # sha256 = "sha256-g4y2fExaOjMJogG8x8K/U3tRy1BZJ8ddZXbi+nc9cYA=";
    rev = "3dbdf14abc3f518684d29c8e34de358200a6766e";
    hash = "sha256-1CoK5XdMKZWlt5q6El418DtZIAAcUNB4vswH7Trtmhw=";
  };

  patches = [ ./path_fix.patch ];

  nativeBuildInputs = [
    findlib
    ocaml_oasis
    ocamlbuild
    makeWrapper
  ];

  buildInputs = [
    ocaml
    parmap
    batteries
    deriving
  ];

  skipConfigure = true;

  buildPhase = ''
    cd src
    ./build
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin/uroboros_util
    chmod +x uroboros.py
    chmod +x bss_creator.py
    chmod +x pic_process.py
    chmod +x pic_process64.py
    chmod +x extern_symbol_process64.py
    chmod +x data_instrumentation.py
    chmod +x useless_func_del.py
    chmod +x filter_nop.py
    chmod +x spliter.py
    chmod +x init_sec_adjust.py
    chmod +x parse_init_array.py
    chmod +x exception_process.py
    chmod +x post_process.py
    chmod +x post_process_lib.py
    chmod +x pre_process.py
    chmod +x export_data.py
    chmod +x func_addr.py
    chmod +x compile_process.py
    chmod +x label_adjust.py
    chmod +x main_discover.py
    chmod +x post_process_data.py
    mv *.py _build/*.native $out/bin/uroboros_util

    makeWrapper "$out/bin/uroboros_util/uroboros.py" "$out/bin/uroboros" \
      --set PATH "${lib.makeBinPath [ bintools python310 coreutils file gcc gawk gnugrep ]}:$out/bin/uroboros_util" \
      --set LC_ALL "C" # otherwise we run into https://askubuntu.com/q/1081901

    runHook postInstall
  '';

}
