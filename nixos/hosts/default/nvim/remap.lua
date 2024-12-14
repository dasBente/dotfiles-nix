-- netrw
vim.keymap.set(
    "n", "<leader>pv", vim.cmd.Ex,
    { desc = "File Explorer" }
)

vim.keymap.set(
    "n", "<leader>pu", vim.cmd.UndotreeToggle,
    { desc = "Undo Tree" }
)

-- move highlighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append next line
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor centered when jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep search centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- swap between tmux sessions
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>rf", vim.lsp.buf.format)

-- search and replace current word
vim.keymap.set(
    "n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Search and Replace Hovered" }
)

-- make current file executable
vim.keymap.set(
    "n", "<leader>x", "<cmd>!chmod +x %<CR>",
    { silent = true, desc = "chmod +x" }
)

-- buffer shortcuts
vim.keymap.set(
    "n", "<C-w>v", ":vnew<CR>",
    { desc = "New buffer (vertical)" }
)

vim.keymap.set(
    "n", "<C-w>e", ":enew<CR>",
    { desc = "New buffer (horizontal)" }
)

-- unbind
local unbind_keys = {
    "Q", "<Up>", "<Left>", "<Right>", "<Down>", "<PageUp>", "<PageDown>"
}

for i = 1, #unbind_keys do
    vim.keymap.set("n", unbind_keys[i], "<nop>");
end
