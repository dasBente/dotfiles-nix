{config, lib, ...}: {
  options = {
    home.nushell.enable = lib.mkEnableOption 
      "Enable nushell in home environment";
  };

  config = lib.mkIf config.home.kitty.enable {
    programs.nushell = {
      enable = true;
      configFile.source = ./config.nu;
    };
  };
}
