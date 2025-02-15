local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
    { "nvim-tree/nvim-web-devicons", enabled = true },
	},
	cmd = "Telescope",
}

function M.config()
  local wk = require("which-key")
  wk.add{
    ["<leader>"] = {
      s = {
        name = "Search",
        h = { "<cmd>Telescope help_tags<CR>", "Search Help" },
        k = { "<cmd>Telescope keymaps<CR>", "Search Keymaps" },
        f = { "<cmd>Telescope find_files<CR>", "Search Files" },
        s = { "<cmd>Telescope builtin<CR>", "Search Select Telescope" },
        w = { "<cmd>Telescope grep_string<CR>", "Search Current Word" },
        g = { "<cmd>Telescope live_grep<CR>", "Search by Grep" },
        d = { "<cmd>Telescope diagnostics<CR>", "Search Diagnostics" },
        r = { "<cmd>Telescope resume<CR>", "Search Resume" },
        b = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzily Search in Current Buffer" },
        ["."] = { "<cmd>Telescope oldfiles<CR>", "Search Recent Files" },
        ["<leader>"] = { "<cmd>Telescope buffers<CR>", "Find Existing Buffers" },
        ["s/"] = { "<cmd>Telescope live_grep grep_open_files=true prompt_title='Live Grep in Open Files'<CR>", "Search in Open Files" },
        n = { "<cmd>Telescope find_files cwd=" .. vim.fn.stdpath("config") .. "<CR>", "Search Neovim Files" },
      },
    },
  }

	require("telescope").setup({
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown(),
			},
		},
	})
	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "ui-select")
end

return M
