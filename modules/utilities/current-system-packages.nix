{ lib, config, pkgs, ... }:
{
  options = {
    utilities.current-system-packages.enable = lib.mkEnableOption
      "Adds list of all installed packages at /etc/current-system-packages";
  };

  config = lib.mkIf config.utilities.current-system-packages.enable {
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
  };
}
