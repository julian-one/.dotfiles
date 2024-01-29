return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "folke/neodev.nvim",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local wk = require "which-key"

        local function on_attach(client, bufnr)
            local buf_opts = { noremap = true, silent = true, buffer = bufnr }

            wk.register({
                g = {
                    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
                    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
                    I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
                    r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
                },
                K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
                ["<leader>l"] = {
                    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
                    f = { "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format" },
                    i = { "<cmd>LspInfo<CR>", "Info" },
                    j = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
                    k = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous Diagnostic" },
                    l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
                    q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quickfix" },
                    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
                    h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
                },
                gl = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic Float" },
            }, buf_opts)

            if client.supports_method "textDocument/inlayHint" then
                vim.lsp.inlay_hint.enable(bufnr, true)
            end

            if client.supports_method "textDocument/inlayHint" then
                vim.lsp.inlay_hint.enable(bufnr, true)
            end
        end

        local function common_capabilities()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            return capabilities
        end

        local function toggle_inlay_hints()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
        end

        -- LSP Server configurations
        local servers = {
            "lua_ls",
            "cssls",
            "html",
            "bashls",
            "gopls",
        }

        -- Diagnostic Configuration
        local default_diagnostic_config = {
            signs = {
                active = true,
                values = {
                    { name = "DiagnosticSignError", text = "E" },
                    { name = "DiagnosticSignWarn", text = "W" },
                    { name = "DiagnosticSignHint", text = "H" },
                    { name = "DiagnosticSignInfo", text = "I" },
                },
            },
            virtual_text = false,
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {
                focusable = true,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        }
        vim.diagnostic.config(default_diagnostic_config)

        for _, sign in ipairs(default_diagnostic_config.signs.values) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
        end

        -- LSP Handler Customization
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
        require("lspconfig.ui.windows").default_options.border = "rounded"

        -- Setup LSP servers
        for _, server in pairs(servers) do
            local opts = {
                on_attach = on_attach,
                capabilities = common_capabilities(),
            }

            if server == "lua_ls" then
                require("neodev").setup {}
            end

            lspconfig[server].setup(opts)
        end

        -- Inlay hints toggle command
        vim.api.nvim_create_user_command('ToggleInlayHints', toggle_inlay_hints, { nargs = 0 })
    end,
}

