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

-- tmux
-- split my window
vim.keymap.set("n", "<leader>sv", ":execute '!tmux splitw -v'<CR>", { desc = "Create a Tmux vertical split" }) -- Create a Tmux vertical split
vim.keymap.set("n", "<leader>ss", ":execute '!tmux splitw -h'<CR>", { desc = "Create a Tmux horizontal split" }) -- Create a Tmux horizontal split
vim.keymap.set("n", "<leader>sx", ":execute '!tmux kill-pane'<CR>", { desc = "Close current Tmux pane" }) -- Close the current Tmux pane
-- resize panes
vim.keymap.set("n", "<leader>sl", ":execute '!tmux resize-pane -L 10'<CR>", { desc = "Resize pane left" })
vim.keymap.set("n", "<leader>sr", ":execute '!tmux resize-pane -R 10'<CR>", { desc = "Resize pane right" })
vim.keymap.set("n", "<leader>su", ":execute '!tmux resize-pane -U 10'<CR>", { desc = "Resize pane up" })
vim.keymap.set("n", "<leader>sd", ":execute '!tmux resize-pane -D 10'<CR>", { desc = "Resize pane down" })
-- synchronizing 
vim.keymap.set("n", "<leader>sy", ":execute '!tmux setw synchronize-panes'<CR>", { desc = "Toggle synchronize panes" })
