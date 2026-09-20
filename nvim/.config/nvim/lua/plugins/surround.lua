return { -- Surround
  'kylechui/nvim-surround',
  event = 'VeryLazy',
  config = function()
    local nvim_surround = require 'nvim-surround'
    local markdown_surrounds = {
      ['m'] = {
        add = function()
          local language = require('nvim-surround.config').get_input 'Markdown code block language (optional): '
          local info = language and language ~= '' and (' ' .. language) or ''
          return { { '```' .. info, '' }, { '', '```' } }
        end,
        find = '(```[^\n]*\n)().-(\n```)()',
        delete = '(```[^\n]*\n)().-(\n```)()',
        label = 'Markdown code block',
      },
    }

    nvim_surround.setup()

    local group = vim.api.nvim_create_augroup('NvimSurroundMarkdown', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      pattern = 'markdown',
      callback = function() nvim_surround.buffer_setup { surrounds = markdown_surrounds } end,
    })

    if vim.bo.filetype == 'markdown' then nvim_surround.buffer_setup { surrounds = markdown_surrounds } end
  end,
}
