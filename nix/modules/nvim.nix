# Original config from https://github.com/ornicar/dotfiles/blob/main/nix/home/modules/neovim.nix

# The idea is to symlink dotfiles/nvim into .config/nvim,
# because I don't want nix to manage my nvim config. LazyVim does it.
{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      ctrlp
      fzf-lua
      indent-blankline-nvim
      lualine-nvim
      neovim-sensible
      nvim-tree-lua
      vim-lastplace
      vim-nix
      #vim-startify
    ];

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Use the external dotfiles nvim config for quicker hacking
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/dotfiles/nvim";

  # stylix.targets.neovim.enable = false;
}
