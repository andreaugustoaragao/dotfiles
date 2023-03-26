require('lualine').setup {
    options = {
        theme = 'auto',
        icons_enabled = true,
        globalstatus = false,
        disabled_filetypes = {
            statusline = { "neo-tree", "Trouble", "guihua", "toggleterm", "qf", "undotree", "diff", "alpha", "packer" },
            winbar = { "neo-tree", "Trouble", "guihua", "toggleterm", "qf", "undotree", "diff", "alpha", "packer" },
            inactive_winbar = { "neo-tree", "Trouble", "guihua", "toggleterm", "qf", "undotree", "diff", "alpha","packer" }
        } 
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {},
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = { 'filetype' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'tabs' }
    },
    winbar = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    inactive_winbar = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    extensions = { "neo-tree", "fugitive", "nvim-dap-ui", "quickfix", "symbols-outline" },
}