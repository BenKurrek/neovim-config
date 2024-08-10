return {
	"phaazon/hop.nvim",
	branch = "v2", -- optional but strongly recommended
	config = function()
		require("hop").setup({
			keys = "etovxqpdygfblzhckisuran",
		})

		-- Keybindings for hop.nvim
		vim.api.nvim_set_keymap("n", "fs", ":HopChar1<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "fS", ":HopChar2<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "fw", ":HopWord<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "fp", ":HopPattern<CR>", { noremap = true, silent = true })
	end,
}
