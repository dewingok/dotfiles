-- Terraform...
vim.filetype.add({
	extension = {
		tf = "terraform",
		tfvars = "terraform",
		tfstate = "json",
	},
})

local trim_trailspace_excluded_filetypes = {
	gitcommit = true,
	markdown = true,
}

local function trim_trailing_whitespace(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end

	local bo = vim.bo[bufnr]
	if bo.buftype ~= "" or bo.binary or not bo.modifiable or bo.readonly then
		return
	end
	if trim_trailspace_excluded_filetypes[bo.filetype] then
		return
	end

	local ok, trailspace = pcall(require, "mini.trailspace")
	if not ok then
		return
	end

	local view = vim.fn.winsaveview()
	vim.api.nvim_buf_call(bufnr, function()
		trailspace.trim()
	end)
	vim.fn.winrestview(view)
end

vim.api.nvim_create_autocmd("FileType", {
	desc = "Fix Terraform commentstring",
	group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
	callback = function(ev)
		vim.bo[ev.buf].commentstring = "#%s"
	end,
	pattern = { "terraform", "hcl" },
})

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Safely trim trailing whitespace on save",
	group = vim.api.nvim_create_augroup("TrimTrailspace", { clear = true }),
	callback = function(args)
		trim_trailing_whitespace(args.buf)
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
