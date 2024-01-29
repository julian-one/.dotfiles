return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
                ensure_installed = {
                    "go", "json", "javascript",
                    "yaml", "html", "css",
                    "markdown", "markdown_inline", "bash",
                    "dockerfile", "gitignore",
                    "lua", "vim", "vimdoc", "query",
                },
            })
        end,
    },
}
