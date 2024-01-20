return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        run = ":TSUpdate",
        requires = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "windwp/nvim-ts-autotag",
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true, -- Enable syntax highlighting
                },
                indent = {
                    enable = true, -- Enable indentation
                },
                ensure_installed = {
                    "go", "json", "javascript", "yaml", "html", "css",
                    "markdown", "bash", "lua", "vim", "dockerfile", "gitignore",
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
                autotag = {
                    enable = true, -- Automatic tag management for HTML/HTMX
                },
                context_commentstring = {
                    enable = true, -- Context-aware commenting based on file type
                },
            })
        end,
    },
}

