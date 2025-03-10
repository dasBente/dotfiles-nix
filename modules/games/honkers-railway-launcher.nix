{ pkgs, lib, config, ... }:
let
  aagl = import (
    builtins.fetchTarball 
    {
      url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
      sha256 = "sha256:0f59radafvzdfn3ar1y6glx9ixc9hbvysaalsp492ixp8ihpkbxv";
    }
  );
in
{
  imports = [ aagl.module ];

  options = {
    games.honkers-railway-launcher.enable =
      lib.mkEnableOption "Enables Honkers Railway Launcher";
  };

  config = lib.mkIf config.games.honkers-railway-launcher.enable {
    nix.settings = aagl.nixConfig;
    programs.honkers-railway-launcher.enable = true;
  };
}
