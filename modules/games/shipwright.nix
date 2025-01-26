{ pkgs, lib, config, ... }:
{
  options = {
    games.shipwright.enable =
      lib.mkEnableOption "Enables Shipwright";
  };

  config = lib.mkIf config.games.shipwright.enable {
    environment.systemPackages = [pkgs.shipwright];
  };
}
