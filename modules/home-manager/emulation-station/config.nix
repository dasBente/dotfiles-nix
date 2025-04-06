{ pkgs, config, lib, ... }:
let
  cfg = config.programs.emulation-station;
in
{
  options.programs.emulation-station = {
    enable = lib.mkEnableOption "Emulation Station";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = with pkgs; [
        emulationstation

        (retroarch.withCores (cores: with cores; [
          bsnes mgba mupen64plus citra dolphin
        ]))
      ];
    }
  ]);
}
