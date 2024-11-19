# GnuK & Nix

(Almost) Everything you need to build and flash GnuK for an ST-Link clone, shipped by a nix-shell environment.

DRAFT, now GnuK is building.

## Usage

- change pwd to this directory
- run `nix-shell gnuk-dev.nix`
- run the scripts in sequence to build GnuK

## Files description

- `gnuk-dev.nix`: the nix shell configuration for building GnuK firmware
- `custompkgs`: extra packages that don't exist in NixPkgs
- `scripts`: scripts for quick actions
- `patches`: some useful or interesting patches

## Notes

The python environment is for testing & regnual upgrading. It's optional when only debug probes are used.
