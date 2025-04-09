{...}: {
  imports = [
    ../../modules/home-manager/default.nix
    ../../modules/home-manager/common.nix
  ];

  home.stateVersion = "24.11"; # do not touch unless necessary!

  home.file = {
  };

  programs.emulation-station.enable = true;
  programs.emulation-station.systems = {
    snes.enable = true;
    n64.enable = true;
    "3ds".enable = true;
  };

  gtk = {
    enable = true;
    theme.name = "adw-gtk3";
    iconTheme.name = "GruvboxPlus";
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = ["neovide.desktop"];
    "application/pdf" = ["zathura.desktop"];
    "image/*" = ["sxiv.desktop"];
    "video/png" = ["mpv.desktop"];
    "video/jpg" = ["mpv.desktop"];
    "video/*" = ["mpv.desktop"];
  };

  home.kitty.enable = true;
}
