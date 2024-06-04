return {
	"echasnovski/mini.nvim",
	-- version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("mini.ai").setup({ n_lines = 500 })

		require("mini.align").setup()

		require("mini.comment").setup()

		require("mini.git").setup()

		require("mini.pairs").setup()

		require("mini.surround").setup()
	end,
}
