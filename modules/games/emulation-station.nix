{ pkgs, lib, config, ... }:
{
  options.games.emulation-station.enable =
      lib.mkEnableOption "Enables Emulation Station Desktop";

  config = lib.mkIf config.games.emulation-station.enable {
    environment.systemPackages = [
      pkgs.emulationstation
    ];
    
  };
}

