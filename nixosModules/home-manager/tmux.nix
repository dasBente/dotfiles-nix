{pkgs, config, lib, ...}: {
  options = {
    tmux.enable = lib.mkEnableOption "Enables tmux in home-manager";
  };

  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;

      plugins = with pkgs.tmuxPlugins; [
        sensible
        power-theme
      ];

      extraConfig = ''
      set-option -g status-position top
      bind C-f run-shell "tmux neww tmux-sessionizer"
      '';
    };
  };
}
