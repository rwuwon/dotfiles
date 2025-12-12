let
	nixpkgs = fetchTarball "https://github.com/NixOs/nixpkgs/tarball/nixos-25.05";
	pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
	packages = with pkgs; [
		cowsay
		lolcat
		curl
		inetutils
		sl
		vim
		tmux
		btop
		htop
		gdu
		openssh
	];

	GREETING = "Hello, Nix!";

	shellHook = ''
		echo $GREETING | cowsay | lolcat
		# curl --version
	'';
}
