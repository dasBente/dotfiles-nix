{pkgs, ...}: {
  imports = [
    ../../home-manager/common.nix
  ];

  home.stateVersion = "24.11"; # do not touch unless necessary!

  home.packages = with pkgs; [
  ];

  home.file = {
  };

  home.sessionVariables = {
    FLAKE_NAME = "nixos";
  };

  programs.git = {
    userName = "dasBente";
    userEmail = "dasbente@gmail.com";
  };
}
