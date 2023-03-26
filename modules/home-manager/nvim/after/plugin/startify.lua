local alpha = require 'alpha'
--require'alpha'.setup(require 'alpha.themes.startify'.config)
local startify = require("alpha.themes.startify")
startify.section.top_buttons.val = {
	startify.button("f", "  Find file", ":Telescope find_files <CR>"),
	startify.button("b", "  File Browser", ":Telescope file_browser <CR>"),
	startify.button("F", "  Find text", ":Telescope live_grep <CR>"),
	--	startify.button("p", "  Search projects", ":Telescope projects<CR>"),
	--	startify.button("z", "  Search Zoxide", ":Telescope zoxide list<CR>"),
	startify.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
	startify.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	startify.button("g", "  NeoGit", ":Neogit <CR>"),
	startify.button("c", "  Neovim Configuration", ":e ~/.config/nvim/init.lua<CR>"),
	startify.button("u", "  Update plugins", ":PackerSync<CR>"),
	startify.button("q", "  Quit", ":qa<CR>"),
}
-- disable mru
--startify.section.mru.val = { { type = "padding", val = 0 } }
startify.section.mru_cwd.val = { { type = "padding", val = 0 } }
startify.nvim_web_devicons.enabled = false
startify.section.bottom_buttons.val = {}
startify.section.footer = { {
	type = "text", val = "footer"
} }
alpha.setup(startify.config)
