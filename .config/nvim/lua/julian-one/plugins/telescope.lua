return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				lazy = true,
			},
		},
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { ".git" },
					path_display = { "smart" },
					prompt_prefix = " ",
					selection_caret = " ",
					entry_prefix = "   ",
					initial_mode = "insert",
					selection_strategy = "reset",
					color_devicons = true,
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob=!.git/",
					},
					mappings = {
						i = {
							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
							["<C-l>"] = actions.complete_tag,
						},
						n = {
							["<esc>"] = actions.close,
							["j"] = actions.move_selection_next,
							["k"] = actions.move_selection_previous,
							["q"] = actions.close,
						},
					},
				},
				pickers = {
					find_files = { theme = "dropdown", previewer = false },
					live_grep = { theme = "dropdown" },
					buffers = {
						theme = "dropdown", -- Use dropdown theme for buffers
						previewer = false, -- Disable previewer for buffers
						initial_mode = "normal", -- Start in normal mode for buffers
						mappings = {
							i = { ["<C-d>"] = actions.delete_buffer }, -- Insert mode mapping
							n = { ["dd"] = actions.delete_buffer }, -- Normal mode mapping
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- Enable fuzzy matching
						override_generic_sorter = true, -- Override generic sorter to use FZF
						override_file_sorter = true, -- Override file sorter to use FZF
						case_mode = "smart_case", -- Smart case matching
					},
				},
			})

			-- Key bindings for launching various Telescope pickers
			vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
			vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep)
			vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers)
			vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)
		end,
	},
}
