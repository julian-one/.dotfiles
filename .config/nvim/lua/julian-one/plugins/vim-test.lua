return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	config = function()
		vim.cmd("let test#strategy = 'vimux'")
		vim.keymap.set("n", "<leader>t", ":TestNearest<CR>")
		vim.keymap.set('n', '<leader>T', ':TestFile<CR>')
	end,
}
