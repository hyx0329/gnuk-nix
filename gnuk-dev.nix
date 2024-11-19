# gnuk-dev.nix
let
  ### unstable
  # nixpkgs_ball = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/master";
  # nixgl_ball = fetchTarball "https://github.com/nix-community/nixGL/archive/main.tar.gz";

  ### pinned
  # use this to get hash: nix-prefetch-url --unpack url
  nixpkgs_ball = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
    sha256 = "1q7y5ygr805l5axcjhn0rn3wj8zrwbrr0c6a8xd981zh8iccmx0p";
  };

  ### import the packages
  pkgs = import nixpkgs_ball {
    config = {
      allowUnfree = true;
    };
    overlays = [ ];
  };

  # Packages in `pkgs.pkgsCross.aarch64-multiplatform` are cross built for aarch64, to 
  # create a target environment, and are only useful when cross building packages for nixos.
  # But packages in `pkgs.pkgsCross.aarch64-multiplatform.buildPackages` are tools to 
  # do the cross building.
  # pkgs'build = pkgs.pkgsCross.aarch64-multiplatform.buildPackages;

  ### Custom pkgs
  custompkgs = import ./custompkgs { pkgs = pkgs; };
in

pkgs.mkShell {
  buildInputs = [
    ### Basics
    pkgs.git
    pkgs.curl
    pkgs.python3

    pkgs.uv # managing python packages in nix is painful

    ### Build tools
    pkgs.gcc-arm-embedded
    custompkgs.arm-none-eabi-picolibc

    ### Flashing tools
    pkgs.openocd
  ];

  # have to be this way to overcome some nix limitations
  # the scripts will utilize these variables
  shellHook = ''
    export PICOLIBC_SPECS=${custompkgs.arm-none-eabi-picolibc}/usr/arm-none-eabi/lib/picolibc.specs
    export PICOLIBCPP_SPECS=${custompkgs.arm-none-eabi-picolibc}/usr/arm-none-eabi/lib/picolibcpp.specs
    export BUILDER_WORKING_DIRECTORY=$(pwd)/build
    mkdir -p $BUILDER_WORKING_DIRECTORY
    '';
}
