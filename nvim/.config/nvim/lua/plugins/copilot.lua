return {
	{ -- Plugin for GitHub Copilot
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{ -- Plugin for Copilot completion
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"yetone/avante.nvim",
		build = function()
			if vim.fn.has("win32") == 1 then
				return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
			else
				return "make"
			end
		end,
		event = "VeryLazy",
		version = false,
		---@module 'avante'
		---@type avante.Config
		opts = {
			provider = "copilot",
			providers = {
				copilot = {
					model = "claude-sonnet-4",
				},
			},
			windows = {
				input = {
					height = 12,
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-telescope/telescope.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-tree/nvim-web-devicons",
			"zbirenbaum/copilot.lua",
			{ -- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = { -- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{ -- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},

	-- { -- Plugin for Copilot chat
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	dependencies = {
	-- 		{ "zbirenbaum/copilot.lua" },
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 		{ "nvim-telescope/telescope.nvim" },
	-- 	},
	-- 	opts = {
	-- 		model = "claude-sonnet-4",
	-- 		debug = true,
	-- 		show_help = true,
	-- 		window = {
	-- 			layout = "float",
	-- 		},
	-- 		auto_follow_cursor = false,
	-- 	},
	-- 	event = "VeryLazy",
	-- 	keys = {
	-- 		{ "<leader>ccv", "<cmd>CopilotChat<cr>", desc = "Open Chat" },
	-- 		{ "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "Explain Code" },
	-- 		{ "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "Review Code" },
	-- 		{ "<leader>ccf", "<cmd>CopilotChatFix<cr>", desc = "Write Bug Fixes" },
	-- 		{ "<leader>cco", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize for performance and readability" },
	-- 		{ "<leader>ccd", "<cmd>CopilotChatDocs<cr>", desc = "Generate Documentation." },
	-- 		{ "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "Generate Test." },
	-- 		{ "<leader>ccm", "<cmd>CopilotChatCommit<cr>", desc = "Write commit message." },
	-- 	},
	-- },
}
