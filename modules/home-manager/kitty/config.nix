{config, lib, ...}: {
  options = {
    home.kitty.enable = lib.mkEnableOption 
      "Enable kitty terminal in home environment";
  };

  config = lib.mkIf config.home.kitty.enable {
    programs.kitty = {
      enable = true;
      extraConfig = builtins.readFile ./themes/monokai.conf;
    };
  };
}
