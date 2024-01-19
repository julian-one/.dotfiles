vim.g.mapleader = " "

-- quick escape
vim.keymap.set("i", "jk", "<ESC>")

-- file exploring
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- auto indent code block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- fancy copy pasta
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- split windows
vim.keymap.set("n", "<leader>sv", "<C-w>v")
vim.keymap.set("n", "<leader>sh", "<C-w>s")
vim.keymap.set("n", "<leader>se", "<C-w>=")
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>")
