local M = {
	"alexghergh/nvim-tmux-navigation",
}

function M.config()
	require("nvim-tmux-navigation").setup({})
  local keymap = vim.keymap.set
	keymap("n", "<C-h>", "<cmd>NvimTmuxNavigateLeft<CR>", {})
	keymap("n", "<C-j>", "<cmd>NvimTmuxNavigateDown<CR>", {})
	keymap("n", "<C-k>", "<cmd>NvimTmuxNavigateUp<CR>", {})
	keymap("n", "<C-l>", "<cmd>NvimTmuxNavigateRight<CR>", {})
	keymap("n", "<C-\\>", "<cmd>NvimTmuxNavigateLastActive<CR>", {})
	keymap("n", "<C-Space>", "<cmd>NvimTmuxNavigateNext<CR>", {})
end

return M
