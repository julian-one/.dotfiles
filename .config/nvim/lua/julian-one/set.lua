-- Hide the GUI cursor when in normal mode.
vim.opt.guicursor = ""
-- More space in the neovim command line for displaying messages.
vim.opt.cmdheight = 2
-- Line numbering: enable both absolute and relative line numbers.
vim.opt.nu = true             -- Enables absolute line numbers.
vim.opt.relativenumber = true -- Enables relative line numbers.

-- Indentation settings: standardize on 4 spaces for a tab.
vim.opt.tabstop = 4      -- Number of spaces that a <Tab> in the file counts for.
vim.opt.softtabstop = 4  -- Number of spaces that a <Tab> counts for while performing editing operations.
vim.opt.shiftwidth = 4   -- Number of spaces to use for each step of (auto)indent.
vim.opt.expandtab = true -- Convert tabs to spaces.

-- Automatically indent new lines.
vim.opt.smartindent = true

-- Do not automatically wrap lines.
vim.opt.wrap = false

-- File backup settings: disable swap and backup files, set undo directory.
vim.opt.swapfile = false                               -- Disable swap file creation.
vim.opt.backup = false                                 -- Disable backup file creation.
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Set the directory for undo files.
vim.opt.undofile = true                                -- Enable persistent undo.

-- Search settings: disable highlighting of search matches, enable incremental search.
vim.opt.hlsearch = false -- Do not highlight all search pattern matches.
vim.opt.incsearch = true -- Show partial matches for a search phrase.

-- Enable 24-bit RGB color in the TUI.
vim.opt.termguicolors = true

-- Scrolling and window layout settings.
vim.opt.scrolloff = 8         -- Start scrolling when we're 8 lines away from margins.
vim.opt.signcolumn = "yes"    -- Always show the sign column.
vim.opt.isfname:append("@-@") -- Include '@' in file names.

-- Reduce time waiting after key press for better responsiveness in certain plugins.
vim.opt.updatetime = 50

-- Highlight column for text width limit.
vim.opt.colorcolumn = "80" -- Highlight column 80 to help maintain line length.

-- Split window preferences.
vim.opt.splitright = true -- When splitting a window, put the new window right of the current one.
vim.opt.splitbelow = true -- When splitting a window, put the new window below the current one.

-- for cmp
vim.opt.completeopt = "menuone,noselect"

-- popup menu
vim.opt.pumheight = 10
vim.opt.pumblend = 10

-- gutter stuff
vim.opt.signcolumn = "yes"

-- netrw
-- vim.g.netrw_banner = 0
