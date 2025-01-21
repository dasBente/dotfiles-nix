#
# Definitions, utils etc. shared by all hosts.
#
{
  pkgs,
  config,
  ...
}: {
  # Update automatically
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };

  nix.settings.auto-optimise-store = true;

  # Write all installed packages to /etc/current-system-packages
  environment.etc."current-system-packages".text = let
    packages =
      builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique =
      builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
    formatted =
      builtins.concatStringsSep "\n" sortedUnique;
  in
    formatted;

  programs.zsh.enable = true;
}
