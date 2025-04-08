{ pkgs, config, lib, ... }:
let
  cfg = config.programs.emulation-station;

  mkSystem = system: attrs: lib.optionalString attrs.enable ''
    <system>
      <name>${system}</name>
      <fullname>${attrs.fullName}</fullname>
      <path>${attrs.romPath or "${cfg.romPath}/${system}"}</path>
      <extension>${attrs.extension}</extension>
      <command>${attrs.command}</command>
      <platform>${attrs.system}</platform>
    </system>
  '';

  mkSystemCfg = systems:
    let
      systems = lib.attrsets.mapAttrsToList mkSystem cfg.systems;
    in ''
      <systemList>
        ${lib.strings.concatLines systems}
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

    systems = lib.mkOption {
      type = lib.types.attrs;
      description = "System definitions";

      default = {
        snes = {
          fullName = "Super Nintendo Entertainment System";
          extension = ".smc .sfc .SMC .SFC";
          command = "retroarch -L ${pkgs.libretro.bsnes}/lib/retroarch/cores/bsnes_libretro.so %ROM%";
        };
        n64 = {
          fullName = "Nintendo 64";
          extension = ".n64 .z64 .N64 .Z64";
          command = "retroarch -L ${pkgs.libretro.mupen64plus}/lib/retroarch/cores/mupen64plus_libretro.so %ROM%";
        };
        "3ds" = {
          fullName = "Nintendo 3DS";
          extension = ".3ds .3DS";
          command = "retroarch -L ${pkgs.libretro.citra}/lib/retroarch/cores/citra_libretro.so %ROM%";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      emulationstation
      retroarch
    ];

    home.file.".emulationstation/es_systems.cfg".text = mkSystemCfg cfg.systems;
  };
}
