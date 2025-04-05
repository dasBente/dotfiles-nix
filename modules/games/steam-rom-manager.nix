{ lib, pkgs, config, ... }:
{
  options.games.steam-rom-manager.enable =
    lib.mkEnableOption "Enables Steam Rom Manager";

  config = lib.mkIf config.games.steam-rom-manager.enable {
    environment.systemPackages = with pkgs; [
      steam-rom-manager
    ];
  };
}
