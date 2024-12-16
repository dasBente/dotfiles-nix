{pkgs, ...}: {
  imports = [
    ../../home-manager/common.nix
  ];

  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "24.11"; # do not touch unless necessary!

  home.packages = with pkgs; [
  ];

  home.file = {
  };

  home.sessionVariables = {
  };
}
