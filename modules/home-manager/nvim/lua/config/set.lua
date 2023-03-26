vim.opt.clipboard = unnamedplus
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.isfname:append("@-@")
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"
vim.g.mapleader = " "

vim.g.airline_powerline_fonts = 1
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.cmd('set nofoldenable')

-- #vim.cmd([[
-- #  augroup FormatOnSave
-- #    autocmd!
-- #    autocmd BufWritePre * lua vim.lsp.buf.format { async = true }
-- #    augroup END
-- #]])
