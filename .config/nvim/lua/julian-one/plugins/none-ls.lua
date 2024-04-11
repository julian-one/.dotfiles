return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting

			null_ls.setup({
				sources = {
					formatting.stylua,
					null_ls.builtins.completion.spell,
					formatting.gofmt,
					formatting.goimports,
                    formatting.golangci_lint,
				},
			})

			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
}
