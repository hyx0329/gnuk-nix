{ pkgs }:
let
  arm-none-eabi-picolibc = pkgs.callPackage (import ./arm-none-eabi-picolibc) { };
in {
  inherit arm-none-eabi-picolibc;
}