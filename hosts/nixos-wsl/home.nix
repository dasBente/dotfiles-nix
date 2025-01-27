{pkgs, ...}: {
  imports = [
    ../../modules/home-manager/common.nix
  ];


  home.packages = with pkgs; [
  ];

  home.file = {
  };
}
