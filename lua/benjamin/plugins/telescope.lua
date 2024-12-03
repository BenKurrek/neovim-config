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
				find_files = {
					hidden = false, -- Exclude hidden files by default
					no_ignore = false, -- Respect .gitignore by default
				},
				live_grep = {
					additional_args = function(opts)
						return {} -- No additional args by default (exclude hidden files)
					end,
				},
			},
		})

		-- Set keymaps
		local keymap = vim.keymap -- For conciseness

		-- Default keymaps (exclude hidden files)
		keymap.set("n", "<leader>ff", function()
			require("telescope.builtin").find_files()
		end, { desc = "Fuzzy find files in cwd" })

		keymap.set("n", "<leader>fs", function()
			require("telescope.builtin").live_grep()
		end, { desc = "Find string in cwd" })

		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

		-- Keymaps for hidden files search including node_modules
		keymap.set("n", "<leader>ffh", function()
			require("telescope.builtin").find_files({
				hidden = true, -- Include hidden files
				no_ignore = true, -- Don't respect .gitignore (include node_modules)
			})
		end, { desc = "Fuzzy find hidden files including node_modules" })

		keymap.set("n", "<leader>fsh", function()
			require("telescope.builtin").live_grep({
				additional_args = function()
					return { "--hidden", "--no-ignore" } -- Include hidden files and don't ignore node_modules
				end,
			})
		end, { desc = "Find string in hidden files including node_modules" })
	end,
}
