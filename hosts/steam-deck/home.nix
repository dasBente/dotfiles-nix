{...}: {
  imports = [
    ../../modules/home-manager/default.nix
    ../../modules/home-manager/common.nix
  ];

  home.stateVersion = "24.11"; # do not touch unless necessary!

  home.file = {
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
