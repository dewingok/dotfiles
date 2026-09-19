return {
  { -- Auto-detect indention
    'NMAC427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  },
	{ -- #1 colorscheme
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
	},
	{ -- Highlight todo, notes, etc in comments
		'folke/todo-comments.nvim',
    config = function()
      require('todo-comments').setup {
        signs = false
      }
    end,
	},
	{ -- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		opts = {},
	},
  { -- Autopairs
  	'windwp/nvim-autopairs',
  	event = 'InsertEnter',
  	dependencies = { 'hrsh7th/nvim-cmp' },
  	config = function()
  		require('nvim-autopairs').setup({})
  		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  		local cmp = require('cmp')
  		cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  	end,
  },
  { -- Surround
    'kylechui/nvim-surround',
    event = 'VeryLazy',
  },
	{ -- Once you Git it, you can't quit it.
		'tpope/vim-fugitive',
	},
	{ -- Better quickfix window
		'kevinhwang91/nvim-bqf',
	},
	{ -- Seemless navigation between Nvim and Tmux.
		'alexghergh/nvim-tmux-navigation',
		config = function()
			local nvim_tmux_nav = require('nvim-tmux-navigation')
			nvim_tmux_nav.setup({
				disable_when_zoomed = true,
			})
			vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
			vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
			vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
			vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
			vim.keymap.set('n', '<C-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive)
			vim.keymap.set('n', '<C-Space>', nvim_tmux_nav.NvimTmuxNavigateNext)
		end,
	},
	{ -- Powerful comments
		'numToStr/Comment.nvim',
	},
	{ -- Better viewing Markdown files
		'MeanderingProgrammer/render-markdown.nvim',
	},
	{ -- GnuPG encryption
    'jamessan/vim-gnupg'
  },
}
