require("monokai-pro").setup {
	transparent_background = false,
	terminal_colors = true,
	devicons = true,
	styles = {
		comment = { italic = true },
		keyword = { bold = true, italic = false },
	},
	filter = "pro",
	day_night = { enable = false },
	inc_search = "background",
}

vim.cmd([[colorscheme monokai-pro]])
