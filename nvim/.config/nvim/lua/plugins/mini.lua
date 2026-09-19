return {
  -- Collection of various small independent plugins/modules
  'nvim-mini/mini.nvim',
  config = function()
    -- Icons
    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()
    -- Simple and easy statusline.
    require('mini.statusline').setup({
      use_icons = vim.g.have_nerd_font,
      section_location = function() return '%2l:%-2v'
    })
    -- Start page
    require('mini.starter').setup()

    -- Better Around/Inside textobjects
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup {
      n_lines = 500,
      mappings = {
        around_next = 'aa',
        inside_next = 'ii',
      },
    }

    -- Trim trailing space
    require('mini.trailspace').setup()

    -- Better diff view and overlay
    require('mini.diff').setup({
      source = require('mini.diff').gen_source.none(),
    })

    -- require('mini.surround').setup({
    --   custom_surroundings = {
    --     m = {
    --       input = { '```[^\n]*\n().-()\n```' },
    --       output = function()
    --         local lang = MiniSurround.user_input('Markdown code block language')
    --         local suffix = (lang ~= nil and lang ~= '') and (' ' .. lang) or ''
    --         return { left = '```' .. suffix .. '\n', right = '\n```' }
    --       end,
    --     },
    --   },
    -- })
  end,
},
