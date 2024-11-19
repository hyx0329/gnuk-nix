{
  lib,
  stdenv,
  fetchFromGitHub,
  gcc-arm-embedded,
  meson,
  ninja,
}:

stdenv.mkDerivation (finalAttrs: {
  _target = "arm-none-eabi";
  pname = "${finalAttrs._target}-picolibc";
  version = "1.8.8";

  nativeBuildInputs = [ gcc-arm-embedded meson ninja ];
  # buildInputs = [
  #   bison
  #   mpi
  #   flex
  #   zlib
  # ];

  src = fetchFromGitHub {
    owner = "picolibc";
    repo = "picolibc";
    rev = "27746bbc246841852912fc3bb5b45094cd8a505a"; # 1.8.8
    hash = "sha256-eYlwQzy+ANGjjW0D81BSxRpapKGfNk7PuuSwZWp59kM=";
  };

  configurePhase = ''
    meson setup \
      --prefix="$out" \
      --cross-file "scripts/cross-${finalAttrs._target}.txt" \
      -Dspecsdir="$out/usr/${finalAttrs._target}/lib" \
      -Dsystem-libc=false \
      --buildtype=plain \
      . \
      build
    '';
  buildPhase = ''
    meson compile -C build
    '';
  installPhase = ''
    meson install -C build
    '';

  meta = {
    description = "A C library designed for embedded 32- and 64- bit systems";
    longDescription = ''
      Picolibc is a set of standard C libraries, both libc and libm, designed for smaller embedded systems with limited ROM and RAM.
      Picolibc includes code from Newlib and AVR Libc. Picolibc has been tested on RISC-V and ARM processors.
    '';
    homepage = "https://keithp.com/picolibc/";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.linux;
  };
})