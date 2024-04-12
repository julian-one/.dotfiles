vim.g.mapleader = " "

-- quick escape
vim.keymap.set("i", "jk", "<ESC>")

-- file exploring
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- fancy copy pasta
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- window stuff
vim.keymap.set('n', '<c-k', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l', ':wincmd l<CR>')
