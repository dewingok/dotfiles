local M = {
	"nvim-neo-tree/neo-tree.nvim",
	version = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
}

function M.config()
	require("neo-tree").setup({
		filesystem = {},
		window = {
			postition = "left",
			width = 30,
		},
	})
	vim.keymap.set("n", "\\", ":Neotree reveal<CR>")
end

return M
