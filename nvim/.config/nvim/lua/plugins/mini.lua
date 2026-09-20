return {
  -- Collection of various small independent plugins/modules
  'nvim-mini/mini.nvim',
  config = function()
    -- Icons
    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()
    -- Simple and easy statusline.
    local catppuccin = require 'catppuccin'
    local palette = require('catppuccin.palettes').get_palette()
    local background = catppuccin.options.transparent_background and 'NONE' or palette.mantle

    local mode_colors = {
      MiniStatuslineModeNormal = { fg = palette.mantle, bg = palette.blue },
      MiniStatuslineModeInsert = { fg = palette.base, bg = palette.green },
      MiniStatuslineModeVisual = { fg = palette.base, bg = palette.mauve },
      MiniStatuslineModeReplace = { fg = palette.base, bg = palette.red },
      MiniStatuslineModeCommand = { fg = palette.base, bg = palette.peach },
      MiniStatuslineModeOther = { fg = palette.base, bg = palette.green },
    }

    local set_bubbles_highlights = function()
      for mode_hl, colors in pairs(mode_colors) do
        local mode_name = mode_hl:gsub('MiniStatuslineMode', '')
        vim.api.nvim_set_hl(0, mode_hl, vim.tbl_extend('force', colors, { bold = true }))
        vim.api.nvim_set_hl(0, 'MiniStatuslineBubble' .. mode_name, { fg = colors.bg, bg = background })
        vim.api.nvim_set_hl(0, 'MiniStatuslineBubble' .. mode_name .. 'OnSection', { fg = colors.bg, bg = palette.surface0 })
        vim.api.nvim_set_hl(0, 'MiniStatuslineBubbleSection' .. mode_name, { fg = colors.bg, bg = palette.surface0 })
      end

      vim.api.nvim_set_hl(0, 'MiniStatuslineBubbleSectionOnBackground', { fg = palette.surface0, bg = background })
    end

    set_bubbles_highlights()

    local project_filename = function()
      if vim.bo.buftype == 'terminal' then return '%t' end

      local path = vim.api.nvim_buf_get_name(0)
      if path == '' then return '%f%m%r' end

      local root = vim.fs.root(0, { '.git' }) or vim.fn.getcwd()
      local relative = vim.fs.relpath(root, path)
      if relative == nil then return '%f%m%r' end

      return relative:gsub('%%', '%%%%') .. '%m%r'
    end

    local bubble_content = function()
      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
      mode_hl = mode_hl:match 'MiniStatuslineMode[%w]+' or 'MiniStatuslineModeOther'
      local mode_name = mode_hl:match 'MiniStatuslineMode([%w]+)' or 'Other'
      local filename = project_filename()
      local git = MiniStatusline.section_git { trunc_width = 40 }
      local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
      local search = MiniStatusline.section_searchcount { trunc_width = 75 }
      local location = '%2l:%-2v'

      return table.concat {
        '%#MiniStatuslineBubble' .. mode_name .. '#',
        '%#' .. mode_hl .. '# ' .. mode .. ' ',
        '%#MiniStatuslineBubble' .. mode_name .. 'OnSection#',
        '%<',
        '%#MiniStatuslineBubbleSection' .. mode_name .. '# ' .. filename .. (git == '' and '' or '  ' .. git) .. ' ',
        '%#MiniStatuslineBubbleSectionOnBackground#',
        '%=',
        '%#MiniStatuslineBubbleSectionOnBackground#',
        '%#MiniStatuslineBubbleSection' .. mode_name .. '# ' .. fileinfo .. ' ',
        '%#MiniStatuslineBubble' .. mode_name .. 'OnSection#',
        '%#' .. mode_hl .. '# ' .. (search == '' and '' or search .. ' ') .. location .. ' ',
        '%#MiniStatuslineBubble' .. mode_name .. '#',
      }
    end

    require('mini.statusline').setup {
      use_icons = vim.g.have_nerd_font,
      content = { active = bubble_content },
    }
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
    require('mini.diff').setup {
      source = require('mini.diff').gen_source.none(),
    }

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
}
