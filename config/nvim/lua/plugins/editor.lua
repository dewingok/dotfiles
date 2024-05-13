return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "echasnovski/mini.align",
    event = "VeryLazy",
    config = function()
      require('mini.align').setup({})
    end,
  },
}
