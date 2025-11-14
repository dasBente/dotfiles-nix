{ config, lib, ...}: {
  options = {
    home.zsh.enable = lib.mkEnableOption "Enables zsh for home manager";
  };

  config = lib.mkIf config.home.zsh.enable {
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

      initContent = ''
      bindkey -s ^f "tmux-sessionizer\n"
      '';
    };
  };
}
