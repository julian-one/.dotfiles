return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",           -- source for text in buffer
        "hrsh7th/cmp-path",             -- source for file system paths
        "hrsh7th/cmp-nvim-lsp",         -- source for Neovim's LSP client
        "hrsh7th/cmp-cmdline",          -- source for command line
        "hrsh7th/cmp-nvim-lua",         -- source for Neovim's Lua API
        {
            "L3MON4D3/LuaSnip",         -- snippet engine
            dependencies = {
                "rafamadriz/friendly-snippets", -- useful snippets
            },
        },
        "saadparwaiz1/cmp_luasnip",     -- for autocompletion
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        require("luasnip/loaders/from_vscode").lazy_load()

        local check_backspace = function()
            local col = vim.fn.col(".") - 1
            return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expandable() then
                        luasnip.expand()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif check_backspace() then
                        fallback()
                    else
                        fallback()
                    end
                end, {
                        "i",
                        "s",
                    }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {
                        "i",
                        "s",
                    }),
            }),
            sources = cmp.config.sources({
                { name = "copilot" },
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- snippets
                { name = "cmp_tabnine" },
                { name = "nvim_lua" },
                { name = "buffer" },  -- text within current buffer
                { name = "path" },    -- file system paths
            }),
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(_, vim_item)
                    -- You can add custom formatting here if needed
                    return vim_item
                end,
            },
            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            window = {
                completion = { border = "rounded", scrollbar = false },
                documentation = { border = "rounded" },
            },
            experimental = {
                ghost_text = false,
            },
        })
    end,
}

