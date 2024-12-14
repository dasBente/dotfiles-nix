require('nvim-treesitter.configs').setup {
	auto_install = false,
	ensure_installed = {}, -- use plugin in home.nix
	highlight = { 
		enable = true,
		additional_vim_regex_highlighting = false;
	},
}

vim.treesitter.language.register("python", "rpy")
