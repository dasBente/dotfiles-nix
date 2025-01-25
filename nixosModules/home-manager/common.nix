{pkgs, ...}: {
  imports = [
    ./default.nix
    ./nvim/config.nix
    ./lf/config.nix
  ];

  home.stateVersion = "24.11"; # do not touch unless necessary!

  home.packages = import ./bins/default.nix {inherit pkgs;};

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  tmux.enable = true;
  zsh.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;

    extraConfig = {
      push = {autoSetupRemote = true;};
      pull = {rebase = true;};
      core = {editor = "nvim";};
      init = {defaultBranch = "main";};
    };

    userName = "dasBente";
    userEmail = "dasbente@gmail.com";

  };
  programs.ssh.extraConfig = ''
  Host dasbente.moe
    HostName git.dasbente.moe
    User git
    Port 222
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
