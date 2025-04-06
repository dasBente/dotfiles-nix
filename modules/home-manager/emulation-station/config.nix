{ pkgs, config, lib, ... }:
let
  cfg = config.programs.emulation-station;

  mkSystem = attr: ''
    <system>
      <name>${attr.system}</name>
      <fullname>${attr.fullName}</fullname>
      <path>${cfg.romPath}/${attr.system}</path>
      <extension>${attr.extension}</extension>
      <command>${attr.command}</command>
      <platform>${attr.system}</platform>
    </system>
  '';

  systemsCfg = ''
    <systemList>
      ${lib.optionalString cfg.snes (mkSystem {
        system = "snes";
        fullName = "Super Nintendo Entertainment System";
        extension = ".smc .sfc .SMC .SFC";
        command = "retroarch -L ${pkgs.libretro.bsnes}/lib/retroarch/cores/bsnes_libretro.so %ROM%";
      })}

      ${lib.optionalString cfg.n64 (mkSystem {
        system = "n64";
        fullName = "Nintendo 64";
        extension = ".n64 .z64 .N64 .Z64";
        command = "retroarch -L ${pkgs.libretro.mupen64plus}/lib/retroarch/cores/mupen64plus_libretro.so %ROM%";
      })}
    </systemList>
  '';
in
{
  options.programs.emulation-station = {
    enable = lib.mkEnableOption "Emulation Station";

    romPath = lib.mkOption {
      default = "~/roms";
      type = lib.types.str;
      description = "Path to the ROM file location";
    };

    snes = lib.mkEnableOption "Enable SNES emulation";
    n64 = lib.mkEnableOption "Enable N64 emulation";
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
    {
      home.file.".emulationstation/es_systems.cfg".text = systemsCfg;
    }
  ]);
}
