return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				-- default find_files without hidden
				find_files = {
					hidden = false,
				},
				live_grep = {
					additional_args = function(opts)
						return {} -- no hidden files by default
					end,
				},
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		-- Keymaps
		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

		-- Keymaps for hidden files search including node_modules
		keymap.set(
			"n",
			"<leader>ffh",
			"<cmd>Telescope find_files hidden=true<cr>",
			{ desc = "Fuzzy find hidden files including node_modules" }
		)
		keymap.set("n", "<leader>fsh", "<cmd>Telescope live_grep<cr>", {
			desc = "Find string in hidden files including node_modules",
			callback = function()
				require("telescope.builtin").live_grep({
					additional_args = function()
						return { "--hidden", "--no-ignore" } -- include hidden files and don't ignore node_modules
					end,
				})
			end,
		})
	end,
}
