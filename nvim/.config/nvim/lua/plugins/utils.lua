return {
  { "jamessan/vim-gnupg" },
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup({})

      vim.keymap.set("n", "<C-h>", "<cmd>NvimTmuxNavigateLeft<CR>", {})
      vim.keymap.set("n", "<C-j>", "<cmd>NvimTmuxNavigateDown<CR>", {})
      vim.keymap.set("n", "<C-k>", "<cmd>NvimTmuxNavigateUp<CR>", {})
      vim.keymap.set("n", "<C-l>", "<cmd>NvimTmuxNavigateRight<CR>", {})
      vim.keymap.set("n", "<C-\\>", "<cmd>NvimTmuxNavigateLastActive<CR>", {})
      vim.keymap.set("n", "<C-Space>", "<cmd>NvimTmuxNavigateNext<CR>", {})
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    spec = {
      {
        { "<leader>c", group = "[C]ode",     mode = { 'n', 'x' } },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>h", group = "Git [H]unk", mode = { 'n', 'v' } },
      },
    },
  },
}
