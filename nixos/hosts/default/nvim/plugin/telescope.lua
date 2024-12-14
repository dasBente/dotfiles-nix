require("telescope").setup()

-- todo: conflicts plugin

local builtin = require("telescope.builtin")

local map = function (mode, key, fn, desc)
	vim.keymap.set(mode, key, fn, { desc = desc })	
end

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find file" })
map("n", "<leader>fg", builtin.live_grep, "Live grep")
map("n", "<leader>fb", builtin.buffers, "Find in buffers")
map("n", "<leader>fh", builtin.help_tags, "Search help")

-- todo: git bindings

