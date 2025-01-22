#
# Definitions, utils etc. shared by all hosts.
#
{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  system = {
    stateVersion = "24.05"; # Did you read the comment?

    # Update automatically
    autoUpgrade.enable = true;
    autoUpgrade.dates = "weekly";
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };

    # Automatic garbage collection
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d";
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
  };

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
  console.keyMap = "de";
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };
}
