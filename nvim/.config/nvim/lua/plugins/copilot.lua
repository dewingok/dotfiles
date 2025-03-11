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
	{ -- Plugin for Copilot chat
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		opts = {
			debug = true,
			show_help = true,
			window = {
				layout = "float",
			},
			auto_follow_cursor = false,
		},
		event = "VeryLazy",
		keys = {
			{ "<leader>ccv", "<cmd>CopilotChat<cr>", desc = "Open Chat" },
			{ "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "Explain Code" },
			{ "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "Review Code" },
			{ "<leader>ccf", "<cmd>CopilotChatFix<cr>", desc = "Write Bug Fixes" },
			{ "<leader>cco", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize for performance and readability" },
			{ "<leader>ccd", "<cmd>CopilotChatDocs<cr>", desc = "Generate Documentation." },
			{ "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "Generate Test." },
			{ "<leader>ccm", "<cmd>CopilotChatCommit<cr>", desc = "Write commit message." },
		},
	},
}
