-- Telescope configuration
return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    },
    config = function()
        local wk = require("which-key")
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
                find_files = {
                    theme = "dropdown",
                    previewer = false,
                },
                live_grep = {
                    theme = "dropdown",
                },
                buffers = {
                    theme = "dropdown",
                    previewer = false,
                    initial_mode = "normal",
                    mappings = {
                        i = {
                            ["<C-d>"] = actions.delete_buffer,
                        },
                        n = {
                            ["dd"] = actions.delete_buffer,
                        },
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,    -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                },
            },
        })

        -- Key bindings
        wk.register({
            ["<leader>bb"] = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
            ["<leader>fb"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
            ["<leader>fc"] = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
            ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find files" },
            ["<leader>fp"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
            ["<leader>ft"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },
            ["<leader>fh"] = { "<cmd>Telescope help_tags<cr>", "Help" },
            ["<leader>fl"] = { "<cmd>Telescope resume<cr>", "Last Search" },
            ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
        })

        -- Maintain your original key bindings
        vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
        vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep)
        vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers)
        vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)
    end,
}

