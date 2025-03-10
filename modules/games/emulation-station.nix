{ pkgs, lib, config, ... }:
{
  options.games.emulation-station.enable =
      lib.mkEnableOption "Enables Emulation Station Desktop";

  config = lib.mkIf config.games.emulation-station.enable {
    environment.systemPackages = with pkgs; [
      emulationstation

      (retroarch.withCores (cores: with cores; [
          bsnes
          mgba
          quicknes
          beetle-psx-hw
          mupen64plus
          citra
          dolphin
        ]))
      ];
  };
}

