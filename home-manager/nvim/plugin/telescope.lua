require("telescope").setup {
	extensions = { undo = {} },
}

local builtin = require("telescope.builtin")

local remap = function (mode, key, fn, desc)
	vim.keymap.set(mode, key, fn, { desc = desc })
end

remap("n", "<leader>ff", builtin.find_files, "Find file")
remap("n", "<leader>fg", builtin.live_grep, "Live grep")
remap("n", "<leader>fb", builtin.buffers, "Find in buffers")
remap("n", "<leader>fh", builtin.help_tags, "Search help")
remap("n", "<leader>fu", "<CMD>Telescope undo<CR>", "Search Undo")

-- fugitive
remap("n", "<leader>gx", "<CMD>Telescope conflicts<CR>", "Conflicts")
remap("n", "<leader>gd", "<CMD>Telescope git_diffs diff_commits<CR>", "Diff")
remap("n", "<leader>gf", builtin.git_files, "Find in git files")
