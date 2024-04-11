-- Define the ColorMyPencils function to apply a given color scheme and additional settings
function ColorMyPencils(color)
    color = color or "catppuccin" -- default to catppuccin if no color is specified
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Setup catppuccin with specified options before loading the color scheme
require("catppuccin").setup({
    flavour = "mocha", -- Options: latte, frappe, macchiato, mocha. "auto" will respect the terminal's background.
    background = {
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    no_underline = false,
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
    },
})

-- Load the catppuccin color scheme explicitly after setup
vim.cmd.colorscheme "catppuccin"

-- Example lazy config update with catppuccin and its configuration
return {
    {
        "catppuccin/nvim",
        lazy = false, -- Load during startup as it is the main colorscheme
        priority = 1000, -- Ensure it loads before other start plugins
        config = function()
            -- Now loading catppuccin with configured options
            ColorMyPencils("catppuccin")
        end
    }
}

