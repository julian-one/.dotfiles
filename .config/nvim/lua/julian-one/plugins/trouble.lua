-- Trouble configuration
return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        -- your existing configuration here
        -- leave it empty to use the default settings
    },
    config = function()
        -- Keybindings for Trouble
        local trouble = require("trouble")
        local keymap = vim.keymap.set

        -- Existing keybindings
        keymap("n", "<leader>xx", function() trouble.toggle() end)
        keymap("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end)
        keymap("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end)
        keymap("n", "<leader>xq", function() trouble.toggle("quickfix") end)
        keymap("n", "<leader>xl", function() trouble.toggle("loclist") end)
        keymap("n", "gR", function() trouble.toggle("lsp_references") end)

        -- Additional keybindings
        keymap("n", "<leader>xt", function() trouble.toggle() end)                                      -- Toggle trouble
        keymap("n", "<leader>xo", function() trouble.open() end)                                        -- Open trouble
        keymap("n", "<leader>xc", function() trouble.close() end)                                       -- Close trouble
        keymap("n", "<leader>xn", function() trouble.next({ skip_groups = true, jump = true }) end)     -- Next item
        keymap("n", "<leader>xp", function() trouble.previous({ skip_groups = true, jump = true }) end) -- Previous item
        keymap("n", "<leader>xf", function() trouble.first({ skip_groups = true, jump = true }) end)    -- First item
        keymap("n", "<leader>xl", function() trouble.last({ skip_groups = true, jump = true }) end)     -- Last item
    end
}

