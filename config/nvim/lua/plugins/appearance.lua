return {
	{ "nvim-tree/nvim-web-devicons" },
	{
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.startify")
			alpha.setup(dashboard.opts)
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					section_separators = {
						left = "",
						right = "",
					},
					component_separators = {
						left = "",
						right = "",
					},
				},
			})
		end,
	},
}
