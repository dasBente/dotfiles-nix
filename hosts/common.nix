{ pkgs, ...}: {
  imports = [
    ../modules/utilities/default.nix
  ];

  # Update automatically
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  nix.settings.auto-optimise-store = true;
  utilities.current-system-packages.enable = true;
  programs.zsh.enable = true;
  programs.direnv.enable = true;

  environment.systemPackages = with pkgs; [
    devenv
    nix-direnv
    wineWowPackages.stable
    winetricks
  ];
}
