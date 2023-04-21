vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
    use 'goolord/alpha-nvim'
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'nvim-telescope/telescope-packer.nvim'
    use 'windwp/nvim-autopairs'
    use({ "catppuccin/nvim", as = "catppuccin" })


    use({
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })

    use { "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {

            }
        end
    }
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    use('theprimeagen/harpoon')

    use('mbbill/undotree')

    use('tpope/vim-fugitive')

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }

    use('folke/zen-mode.nvim')
    use("eandrju/cellular-automaton.nvim")
    use "lukas-reineke/indent-blankline.nvim"
    use('nvim-lualine/lualine.nvim')

    use 'ray-x/go.nvim'
    use { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' }
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use { 'theHamsta/nvim-dap-virtual-text' }
    use {
        "nvim-zh/colorful-winsep.nvim",
        config = function()
            require('colorful-winsep').setup()
        end
    }

    -- Unless you are still migrating, remove the deprecated commands from v1.x
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

    use({
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = function()
            require("persistence").setup()
        end,
    })

    use {
        "echasnovski/mini.nvim",
        config = function()
            require('mini.bufremove').setup()
        end,
    }

    use({ 'rose-pine/neovim', as = 'rose-pine' })

    use({
        "DaikyXendo/nvim-material-icon",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            local web_devicons_ok, web_devicons = pcall(require,
                "nvim-web-devicons")
            if not web_devicons_ok then return end

            local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
            if not material_icon_ok then return end
            web_devicons.setup({ override = material_icon.get_icons() })
            require("nvim-material-icon").setup()
        end
    })

    use { "akinsho/toggleterm.nvim", tag = "*" }
    -- Lua
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }


    use 'arkav/lualine-lsp-progress'

    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig"
    }

    use 'mfussenegger/nvim-jdtls'
end)
