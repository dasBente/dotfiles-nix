{ pkgs, lib, config, ... }:
{
  options = {
    games.dwarf-fortress.enable = lib.mkEnableOption "Enables Dwarf Fortress";
  };

  config = lib.mkIf config.games.dwarf-fortress.enable {
    environment.systemPackages = with pkgs.dwarf-fortress-packages; [
      (dwarf-fortress-full.override {
        theme = "obsidian";
        enableDwarfTherapist = true;
        enableLegendsBrowser = true;
        enableFPS = true;
      })
    ];
  };
}
