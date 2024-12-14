{ pkgs, ... }:
{
  programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraPackages = with pkgs; [
        lua-language-server
        nil
        xclip
        wl-clipboard
        ripgrep
        fd
      ];

      extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./remap.lua}
      ${builtins.readFile ./plugin/telescope.lua}
      '';

      defaultEditor = true;

      plugins = with pkgs.vimPlugins; [
        luasnip
        neodev-nvim
        nvim-web-devicons

        {
          plugin = which-key-nvim;
          config = toLuaFile ./plugin/which-key.lua;
        }


        {
          plugin = comment-nvim;
          config = toLua "require(\"Comment\").setup()";
        }

        # cmp and plugins
        cmp-nvim-lsp
        cmp_luasnip

        {
          plugin = nvim-cmp;
          config = toLuaFile ./plugin/cmp.lua;
        }

        # lsp
        lsp-zero-nvim
        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./plugin/lsp.lua;
        }

        # telescope
        telescope-nvim
        telescope-undo-nvim

        # treesitter
        {
          plugin = (nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
          ]));
          config = toLuaFile ./plugin/treesitter.lua;
        }

        vim-nix
      ];
    };
}
