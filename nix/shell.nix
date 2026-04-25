let
  #nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-25.11";
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    cowsay
    lolcat
    #curl
  ];

  GREETING = "Hello, Nix!";

  shellHook = ''
    echo $GREETING | cowsay | lolcat
    echo -e "\nPackages in this nix-shell: cowsay lolcat curl\n"
    curl -V
    echo -e "\nTips:"
    echo -e "-----"
    echo nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/tarball/nixos-25.11 -p curl --run curl -V
    echo nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz -p curl --run curl -V
  '';
}
