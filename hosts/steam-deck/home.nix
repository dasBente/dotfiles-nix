{...}: {
  imports = [
    ../../modules/home-manager/default.nix
    ../../modules/home-manager/common.nix
  ];

  home.stateVersion = "24.11"; # do not touch unless necessary!

  home.file = {
  };

  home.packages = [
  ];

  programs.emulation-station = {
    enable = true;
    romPath = "/run/media/dasbente/7aa6e9a3-4398-4c82-9f5e-f078da5557cc/Emulation/roms";
    systems = {
      snes.enable = true;
      n64.enable = true;
      n3ds.enable = true;
      gbc.enable = true;
      gc.enable = true;
    };
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
