return {
  "nvimtools/none-ls.nvim",
  config = function()
    local nls = require("null-ls")
    local fmt = nls.builtins.formatting
    local diag = nls.builtins.diagnostics
    nls.setup({
      sources = {
        fmt.stylua,
        fmt.black,
        fmt.isort,
        fmt.terraform_fmt,
        diag.yamllint,
        diag.zsh,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
