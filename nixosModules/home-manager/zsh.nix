{ config, lib, ...}: {
  options = {
    zsh.enable = lib.mkEnableOption "Enables zsh for home manager";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = false;

      shellAliases = {
        ll = "ls -l";
        edit = "sudo -e";
      };

      oh-my-zsh = {
        enable = true;
        plugins = ["git" "z" "node" "npm" "aliases"];
        theme = "avit";
      };

      initExtra = ''
      bindkey -s ^f "tmux-sessionizer\n"
      '';
    };
  };
}
