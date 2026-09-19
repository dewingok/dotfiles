return {
  -- Autoformat
  'stevearc/conform.nvim',
  config = function ()
    require('conform').setup {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Filetypes to autoformat on save here
        local enabled_filetypes = {
          lua = true,
          python = true,
        }
        if enabled_filetypes[vim.bo[bufnr].filetype] then
          return { timeout_ms = 500 }
        else
          return nil
        end
      end,
      default_format_opts = {
        lsp_format = 'fallback',
      },
      -- Specify external formatters
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        json = { 'prettier' },
        toml = { 'prettier' },
      },
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
  end,
}
