-- ~/.config/nvim/init.lua

-- Load core settings and lazy.nvim
require("benjamin.core")
require("benjamin.lazy")

-- Performance optimizations
vim.o.updatetime = 250
vim.wo.wrap = false

vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		prefix = "●",
	},
	update_in_insert = false,
})

-- Enable logging for debugging
vim.lsp.set_log_level("debug")
