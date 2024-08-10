return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({
			-- enable syntax highlighting
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = { enable = true },
			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = {
				enable = true,
			},
			-- ensure these language parsers are installed
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				"rust",
				"python",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			-- enable folding
			folding = {
				enable = true,
			},
		})

		-- set foldmethod and foldexpr for Treesitter
		vim.o.foldmethod = "expr"
		vim.o.foldexpr = "nvim_treesitter#foldexpr()"
		vim.o.foldlevel = 99 -- Start with all folds open

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "zc", "zc", { noremap = true, silent = true, desc = "Close fold under cursor" })
		keymap.set("n", "zo", "zo", { noremap = true, silent = true, desc = "Open fold under cursor" })
		keymap.set("n", "za", "za", { noremap = true, silent = true, desc = "Toggle fold under cursor" })
		keymap.set("n", "zM", "zM", { noremap = true, silent = true, desc = "Close all folds" })
		keymap.set("n", "zR", "zR", { noremap = true, silent = true, desc = "Open all folds" })
	end,
}
