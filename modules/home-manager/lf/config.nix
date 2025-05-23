{ lib, pkgs, config, ... }: {
  options.home.lf.enable = lib.mkEnableOption
    "Enable lf with opinionated defaults";
  
  config = lib.mkIf config.home.lf.enable {
    xdg.configFile."lf/icons".source = ./icons;

    programs.lf = {
      enable = true;
      commands = {
        dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
        editor-out = ''$$EDITOR $f'';
      };

      settings = {
        preview = true;
        hidden = true;
        drawbox = true;
        icons = true;
        ignorecase = true;
      };

      keybindings = {
        V = ''''$${pkgs.bat}/bin/bat --paging=always --theme=gruvbox "$f"'';
        "<enter>" = "open";
        "c" = "mkdir";
        "." = "set hidden!";
        "`" = "mark-load";
        do = "dragon-out";
        ee = "editor-open";
      };

      extraConfig = let
        previewer = pkgs.writeShellScriptBin "pv.sh" ''
        file=$1
        w=$2
        h=$3
        x=$4
        y=$5

        if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]
        then
        ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no \
        --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" \
        < /dev/null > /dev/tty

        exit 1
        fi

        ${pkgs.pistol}/bin/pistol "$file"
        '';
        cleaner = pkgs.writeShellScriptBin "clean.sh" ''
        ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
        '';
      in ''
      set cleaner ${cleaner}/bin/clean.sh
      set previewer ${previewer}/bin/pv.sh
      '';
    };
  };
}
