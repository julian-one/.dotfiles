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

-- split my window
vim.keymap.set("n", "<leader>sv", "<C-w>v")         -- Create a vertical split
vim.keymap.set("n", "<leader>se", "<C-w>=")         -- Make all splits equal size
vim.keymap.set("n", "<leader>ss", "<C-w>s")         -- Create a horizontal split
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>") -- Close current split

vim.keymap.set("n", "<leader>sl", "<C-w>l")         -- Move to the right split
vim.keymap.set("n", "<leader>sh", "<C-w>h")         -- Move to the left split (reassigned to avoid conflict)
vim.keymap.set("n", "<leader>sj", "<C-w>j")         -- Move to the lower split
vim.keymap.set("n", "<leader>sk", "<C-w>k")         -- Move to the upper spli sh
