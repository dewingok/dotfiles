-- Terraform...
vim.filetype.add({
	extension = {
		tf = "terraform",
		tfvars = "terraform",
		tfstate = "json",
	},
})
vim.api.nvim_create_autocmd("FileType", {
	desc = "Fix Terraform commentstring",
	group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
	callback = function(ev)
		vim.bo[ev.buf].commentstring = "#%s"
	end,
	pattern = { "terraform", "hcl" },
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "SuggestCommitMessage",
	callback = function()
		require("avante.config").override({ system_prompt = "Write commit message using commitizen convention" })
	end,
})
vim.keymap.set("n", "<leader>am", function()
	vim.api.nvim_exec_autocmds("User", { pattern = "SuggestCommitMessage" })
end, { desc = "Avante: Suggest commit message" })
