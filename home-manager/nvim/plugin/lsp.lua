local on_attach = function (_, bufnr)
	local bufmap = function (mode, keys, func, desc)
		vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
	end

	local builtin = require("telescope.builtin")

	bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
	bufmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
	bufmap("n", "gI", vim.lsp.buf.implementation, "Go to implementation")

	-- info
	bufmap("i", "<C-h>", vim.lsp.buf.signature_help, "Signature Help")
	bufmap("n", "K", vim.lsp.buf.hover, "Hover")
	bufmap("i", "<C-k>", vim.lsp.buf.hover, "Hover")

	-- diagnostics
	bufmap("n", "<leader>dd", vim.diagnostic.open_float, "Show diagnostic")
	bufmap("n", "<leader>dj", vim.diagnostic.goto_next, "Next diagnostic")
	bufmap("n", "<leader>dk", vim.diagnostic.goto_prev, "Prev diagnostic")
	bufmap("n", "<leader>df", builtin.diagnostics, "Search diagnostics")
	bufmap("n", "<leader>db", function ()
		builtin.diagnostics({ bufnr = 0 })
	end, "Search diagnostics in buffer")

	-- code actions
	bufmap("n", "<leader>va", vim.lsp.buf.code_action, "Code Actions")
	bufmap("n", "<leader>vr", vim.lsp.buf.rename, "Rename symbol")

	-- telescope
	bufmap("n", "<leader>vv", builtin.lsp_references, "References")
	bufmap("n", "<leader>vs", builtin.lsp_document_symbols, "Document Symbols")
	bufmap("n", "<leader>vw", builtin.lsp_workspace_symbols, "Workspace Symbols")
	bufmap("n", "<leader>vi", builtin.lsp_incoming_calls, "Incoming Calls")
	bufmap("n", "<leader>vo", builtin.lsp_outgoing_calls, "Outgoing Calls")

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function (_)
		vim.lsp.buf.format()
	end, {})
end

local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.on_attach(on_attach)
lsp.setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("neodev").setup()

require("lspconfig").nil_ls.setup {}

require("lspconfig").lua_ls.setup {
	on_init = function (client)
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			return
		end
	end,
	capabilities = capabilities,

	root_dir = function ()
		return vim.loop.cwd()
	end,

	workspace = {
		checkThirdParty = false,
		library = { vim.env.VIMRUNTIME },
	},

	settings = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = { globals = { "vim" } },
		},
	},
}

require("lspconfig").bashls.setup {
	filetypes = { "bash", "sh", "zsh" },
}

require("lspconfig").ts_ls.setup {}
