{ pkgs, config, lib, ... }:
let
  cfg = config.programs.emulation-station;

  defaultSystems = {
    snes = {
      fullName = "Super Nintendo Entertainment System";
      extension = ".smc .sfc .SMC .SFC";
      command = "retroarch -L ${pkgs.libretro.bsnes}/lib/retroarch/cores/bsnes_libretro.so %ROM%";
    };

    n64 = {
      fullName = "Nintendo 64";
      extension = ".n64 .z64 .N64 .Z64";
      command = "retroarch -L ${pkgs.libretro.mupen64plus}/lib/retroarch/cores/mupen64plus_next_libretro.so %ROM%";
    };

    n3ds = {
      fullName = "Nintendo 3DS";
      extension = ".nds .NDS .3ds .3DS";
      command = "retroarch -L ${pkgs.libretro.citra}/lib/retroarch/cores/citra_libretro.so %ROM%";
    };

    gc = {
      fullName = "Nintendo Gamecube";
      extension = ".rvz .RVZ .iso .ISO";
      command = "retroarch -L ${pkgs.libretro.dolphin}/lib/retroarch/cores/dolphin_libretro.so %ROM%";
    };

    wii = {
      fullName = "Nintendo Wii";
      extension = ".rvz .RVZ .iso .ISO";
      command = "retroarch -L ${pkgs.libretro.dolphin}/lib/retroarch/cores/dolphin_libretro.so %ROM%";
    };

    gbc = {
      fullName = "Gameboy Color";
      extension = ".gbc .GBC";
      command = "retroarch -L ${pkgs.libretro.mgba}/lib/retroarch/cores/mgba_libretro.so %ROM%";
    };
  };

  getKeyOr = key: attrs: default:
    if builtins.hasAttr key attrs then builtins.getAttr key attrs else default;

  hasKeyString = key: attrs: str:
    lib.optionalString (builtins.hasAttr key attrs) str;

  mkSystem = system: attrs: hasKeyString "enable" attrs ''
    <system>
      <name>${system}</name>
      ${hasKeyString "fullName" attrs "<fullname>${attrs.fullName}</fullname>"}
      <path>${getKeyOr "romPath" attrs "${cfg.romPath}/${system}"}</path>
      <extension>${attrs.extension}</extension>
      <command>${attrs.command}</command>
      <platform>${system}</platform>
    </system>
  '';

  mkSystemCfg = systems:
    let
      asList = lib.attrsets.mapAttrsToList mkSystem systems;
    in ''
      <systemList>
        ${lib.strings.concatLines asList}
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
      description = "Overrides for pre-defined systems.";
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      emulationstation
      retroarch
    ];

    home.file.".emulationstation/es_systems.cfg".text = 
      mkSystemCfg (lib.attrsets.recursiveUpdate defaultSystems cfg.systems);

    home.file.".local/share/applications/Emulation Station.desktop".text = ''
      [Desktop Entry]
      Name=Emulation Station
      Exec=${pkgs.emulationstation}/bin/emulationstation
      Icon=${pkgs.emulationstation}/share/emulationstation/resources/window_icon_256.png
      Type=Application
      Category=Game;
      Terminal=false
    '';
  };
}
