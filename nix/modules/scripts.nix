# btop prior to v1.4.6 lacks a "save_config_on_exit" option
# This leads to btop.conf not being locked, so here, we'll use a module to
# force the config to stay unchanged.

# https://github.com/aristocratos/btop/releases/tag/v1.4.6

{ pkgs, config, ... }:
{
  home.file = {
    #"scripts/pi.sh".text = ''
    #  '';
    "scripts/pi.sh".source = config.lib.file.mkOutOfStoreSymlink "/home/${config.home.username}/nix/scripts/pi.sh";
  };
}
