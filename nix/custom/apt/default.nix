# default.nix

# apt 3.2.0: For trying out `apt history-list` and `apt history-info`
# Do not use for operations requiring root!

# Build: nix-env -A apt
# Setup: cp /var/log/apt/* result/var/log/apt/
# Run: result/bin/apt --version

let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-25.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
  apt = pkgs.callPackage ./apt.nix { };
}
