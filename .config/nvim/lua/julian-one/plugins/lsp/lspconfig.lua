return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local opts = { noremap = true, silent = true }

        local function organize_imports_sync(bufnr, timeout_ms)
            local params = vim.lsp.util.make_range_params()
            params.context = { only = { "source.organizeImports" } }
            local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, timeout_ms)
            for _, res in pairs(result or {}) do
                for _, action in pairs(res.result or {}) do
                    if action.edit or type(action.command) == "table" then
                        if action.edit then
                            local client = vim.lsp.get_client_by_id(vim.lsp.get_active_clients({ bufnr = bufnr })[1].id)
                            vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
                        end
                        if action.command then
                            vim.lsp.buf.execute_command(action.command)
                        end
                    end
                end
            end
        end

        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)             -- show definition, references
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)                         -- go to declaration
            vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)            -- show lsp definitions
            vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)        -- show lsp implementations
            vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)       -- show lsp type definitions
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)        -- see available code actions, in visual mode will apply to selection
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)                      -- smart rename
            vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)                -- show diagnostics for line
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)                        -- jump to previous diagnostic in buffer
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)                        -- jump to next diagnostic in buffer
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)                                -- show documentation for what is under cursor
            vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)                       -- mapping to restart lsp if necessary
        end

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Change the Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- configure html server
        lspconfig["html"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure css server
        lspconfig["cssls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure tailwindcss server
        lspconfig["tailwindcss"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure emmet language server
        lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "html", "css" },
        })

        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }, -- Recognize the `vim` global
                    },
                    workspace = {
                        library = {
                            -- This loads the `lua` files from `nvim` to allow for completion of the `vim` api.
                            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            [vim.fn.stdpath('config') .. '/lua'] = true,
                        },
                    },
                    -- other settings ...
                },
            },
            on_attach = on_attach,
            capabilities = capabilities,
        })


        lspconfig["gopls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- Create an autocmd group for formatting
        local fmt_group = vim.api.nvim_create_augroup("Fmt", { clear = true })

        -- Global autocmd for auto-formatting
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = fmt_group,
            pattern = "*",
            callback = function()
                local bufnr = vim.api.nvim_get_current_buf()

                -- Check all attached clients for formatting capability
                local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
                for _, client in pairs(clients) do
                    if client.server_capabilities.documentFormattingProvider then
                        organize_imports_sync(bufnr, 1000)
                        vim.lsp.buf.format({ bufnr = bufnr })
                        return -- Exit after formatting
                    end
                end
            end,
        })
    end,
}
