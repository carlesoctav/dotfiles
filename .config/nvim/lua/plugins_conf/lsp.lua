vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func)
			vim.keymap.set("n", keys, func, { buffer = event.buf })
		end

		map("gd", require("telescope.builtin").lsp_definitions)
		map("gr", require("telescope.builtin").lsp_references)
		map("gI", require("telescope.builtin").lsp_implementations)
		map("<leader>D", require("telescope.builtin").lsp_type_definitions)
		map("<leader>ds", require("telescope.builtin").lsp_document_symbols)
		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols)
		map("<leader>rn", vim.lsp.buf.rename)
		map("[d", vim.diagnostic.goto_prev)
		map("]d", vim.diagnostic.goto_next)
		map("<leader>ra", vim.lsp.buf.code_action)
		map("K", vim.lsp.buf.hover)
		map("gD", vim.lsp.buf.declaration)
		map("<leader>f", function()
			require("conform").format({ lsp_fallback = true })
		end)

		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
local servers = {
	pyright = {},
	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
					library = {
						"${3rd}/luv/library",
						unpack(vim.api.nvim_get_runtime_file("", true)),
					},
				},
			},
		},
	},
}
require("mason").setup()

local ensure_installed = vim.tbl_keys(servers or {})

require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			require("lspconfig")[server_name].setup({
				cmd = server.cmd,
				settings = server.settings,
				filetypes = server.filetypes,
				-- This handles overriding only values explicitly passed
				-- by the server configuration above. Useful when disabling
				-- certain features of an LSP (for example, turning off formatting for tsserver)
				capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
			})
		end,
	},
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff", "black" },
		javascript = { { "prettierd", "prettier" } },
	},
})
