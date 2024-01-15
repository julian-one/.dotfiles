local lspconfig = require('lspconfig')
local lsp_zero = require('lsp-zero')

lsp_zero.preset('recommended')
lsp_zero.setup({
    -- Additional global lsp-zero configuration if needed
})

-- Configure 'gopls' with lsp_zero's on_attach function and custom settings
lspconfig.gopls.setup({
    on_attach = function(client, bufnr)
        -- Default key mappings
        lsp_zero.default_keymaps({buffer = bufnr})
        vim.keymap.set('n', '<leader>th', vim.lsp.buf.hover, {buffer = bufnr})
        -- Key binding for 'Jump to Definition'
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer = bufnr})
        -- Key binding for 'Jump to Type Definition'
        vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, {buffer = bufnr})
        

        if client.name == "gopls" then
            local go_augroup = vim.api.nvim_create_augroup("GoLspActions", { clear = true })

            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    local params = { textDocument = vim.lsp.util.make_text_document_params() }
                    -- Organize imports synchronously
                    local import_result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000) -- 1000ms timeout
                    for _, res in pairs(import_result or {}) do
                        for _, action in pairs(res.result or {}) do
                            if action.kind == "source.organizeImports" then
                                if action.edit then
                                    vim.lsp.util.apply_workspace_edit(action.edit, 'utf-16')
                                elseif action.command then
                                    vim.lsp.buf.execute_command(action.command)
                                end
                            end
                        end
                    end

                    -- Format synchronously after organizing imports
                    vim.lsp.buf.format({ async = false })
                end,
                group = go_augroup,
            })
        end
    end,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
})

-- Mason setup
require('mason').setup({
    -- Mason configuration if needed
})

require('mason-lspconfig').setup({
    ensure_installed = { 'gopls' },
    automatic_installation = true,
})

-- Optionally enable LSP logging for troubleshooting
vim.lsp.set_log_level("debug")

