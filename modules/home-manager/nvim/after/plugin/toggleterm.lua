require("toggleterm").setup {
    hide_numbers = true,
    autochdir = true,
    shade_terminals = false,
    start_in_insert = true,
    persist_mode = true,
}

local Terminal = require('toggleterm.terminal').Terminal
local htop = Terminal:new({
    cmd = "htop",
    hidden = true,
    direction = "float"
})

function Htop_toggle() htop:toggle() end

vim.api.nvim_set_keymap("n", "<leader><leader>th",
    "<cmd>lua Htop_toggle()<CR>", {
        noremap = true,
        silent = true,
        desc = "toggle htop"
    })

vim.keymap.set("n", "<leader><leader>tf",
    "<CMD>ToggleTerm direction=float<CR>",
    { desc = "toggle floating terminal" })
