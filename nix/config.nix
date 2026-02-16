# https://nixos.org/manual/nixpkgs/stable/#sec-getting-documentation
# nix-channel --list
# nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
# nix-channel --update nixpkgs
# nix-env -iA nixpkgs.myPackages

{
  packageOverrides =
    pkgs: with pkgs; {
      myPackages = buildEnv {
        name = "my-packages";
        paths = [
          man
          nix
          vim-full
          yt-dlp
          deno
        ];
        pathsToLink = [
          "/share/man"
          "/share/doc"
          "/bin"
        ];
        extraOutputsToInstall = [
          "man"
          "doc"
        ];
      };
  };
}
