return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig", -- Added dependency
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"ts_ls",
				"html",
				"jsonls",
				"marksman",
				"pyright",
				"rust_analyzer",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"prismals", -- Ensure this is the correct server name
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- Prettier formatter
				"stylua", -- Lua formatter
				"isort", -- Python formatter
				"black", -- Python formatter
				"pylint",
				"eslint_d",
				"rstcheck",
				"rustfmt", -- Rust formatter
			},
		})
	end,
}
