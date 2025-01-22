{pkgs, ...}: {
  imports = [
    ../../home-manager/common.nix
  ];


  home.packages = with pkgs; [
  ];

  home.file = {
  };
}
