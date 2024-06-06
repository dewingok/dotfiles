return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "j-hui/fidget.nvim",
    "lukas-reineke/lsp-format.nvim",
  },
  config = function()
    local on_attach = require("lsp-format").on_attach
    local capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )
    local handlers = {
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilties = capabilities,
          on_attach = on_attach,
        })
      end,
    }

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "terraformls",
        "yamlls",
        "pyright",
      },
      handlers = handlers,
    })

    local tools = {
      "stylua",
      "black",
      "isort",
      "tflint",
    }
    require("mason-tool-installer").setup({ ensure_installed = tools })
  end,
}
