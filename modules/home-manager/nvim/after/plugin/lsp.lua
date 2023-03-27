local mason_options = {
    automatic_installation = false, -- use nix
    ui = {
        icons = {
            package_installed = " ",
            package_pending = " ",
            package_uninstalled = "",
        },
    },
}

require ("mason").setup(mason_options)

local mason_lspconfig_options = {
    ensure_installed = { "dockerls", "docker_compose_language_service", "marksman", "nil_ls", "jsonls", "bashls", "yamlls", "lua_ls", "taplo", "gopls", "jdtls", "rust_analyzer"}
}
require("mason-lspconfig").setup(mason_lspconfig_options)

local common_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())


local common_on_attach = function(client, bufnr)
    local navic = require("nvim-navic")
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end


    local function fix_imports()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        local result = vim.lsp.buf_request_sync(0,
            "textDocument/codeAction",
            params)
        for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
                else
                    vim.lsp.buf.execute_command(r.command)
                end
            end
        end
    end

    if client.name == "gopls" then
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            group = vim.api.nvim_create_augroup("FixGoImports", { clear = true }),
            pattern = "*.go",
            callback = function()
                fix_imports()
            end
        })
    end

    client.server_capabilities.document_formatting = true
    client.server_capabilities.document_range_formatting = true


    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, remap = false, desc = "go to definition" })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, remap = false, desc = "hover" })
    vim.keymap.set('n', 'gw', vim.lsp.buf.workspace_symbol, { buffer = bufnr, remap = false, desc = "workspace symbol" })
    vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float,
        { buffer = bufnr, remap = false, desc = "diag open float" })

    vim.keymap.set('n', '[d', vim.diagnostic.goto_next, { buffer = bufnr, remap = false, desc = "diag goto next" })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, { buffer = bufnr, remap = false, desc = "diag goto prev" })
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { buffer = bufnr, remap = false, desc = "code action" })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, remap = false, desc = "references" })
    vim.keymap.set('n', 'gn', vim.lsp.buf.rename, { buffer = bufnr, remap = false, desc = "rename" })
    vim.keymap.set('i', 'gh', vim.lsp.buf.signature_help, { buffer = bufnr, remap = false, desc = "signature" })
    vim.keymap.set('n', 'gl', vim.lsp.buf.incoming_calls, { buffer = bufnr, remap = false, desc = "incoming calls" })
    vim.keymap.set('n', 'gm', vim.lsp.buf.implementation, { buffer = bufnr, remap = false, desc = "implementation" })

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            group = vim.api.nvim_create_augroup("SharedLspFormatting", { clear = true }),
            pattern = "*",
            command = "lua vim.lsp.buf.format()"
        })
    end
end


local function common_handlers()
    return {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                -- Your common diagnostic options here, e.g.:
                underline = true,
                virtual_text = {
                    spacing = 4,
                    prefix = '●',
                },
                signs = {
                    priority = 20,
                },
                update_in_insert = false,
                severity_sort = false,
            }
        ),
    }
end


--https://sookocheff.com/post/vim/neovim-java-ide/
local home = os.getenv('HOME')
local root_markers = { 'gradlew', 'mvnw', 'pom.xml', '.git' }
local root_dir_local = require('jdtls.setup').find_root(root_markers)
-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir_local, ":p:h:t")

local common_settings = {
    Lua = {
        runtime =  {
            version = 'LuaJIT',
        },
        workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
            enable = false,
        },
        diagnostics = {
            globals = { 'vim' },
        }
    },
    gopls = {
        analyses = {
            unusedparams = true,
            unreachable = true,
            fieldalignment = true,
            nilness = true,
            shadow = true,
            unusedvariable = true,
        },
        experimentalPostfixCompletions = true,
        hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true
        },
        codelenses = {
            generate = true,
            gc_details = true,
            test = true,
            tidy = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        matcher = 'fuzzy',
        diagnosticsDelay = '500ms',
        gofumpt = true
    }
}

for _,lsp in ipairs(mason_lspconfig_options.ensure_installed) do 
    require("lspconfig")[lsp].setup{
        on_attach = function (client, bufnr)
            common_on_attach(client, bufnr)
        end,
        handlers = common_handlers(),
        capabilities = common_capabilities,
        settings = common_settings,
    }
end






require("lspconfig")["jdtls"].setup {
    on_attach = function(client, bufnr)
        common_on_attach(client, bufnr)
    end,
    handlers = common_handlers(),
    --  root_dir = root_dir_local,
    settings = {
        java = {
            format = {
                settings = {
                    -- Use Google Java style guidelines for formatting
                    -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
                    -- and place it in the ~/.local/share/eclipse directory
                    url = "/.local/share/eclipse/eclipse-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' }, -- Use fernflower to decompile library code
            -- Specify any completion options
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*", "sun.*",
                },
            },
            -- Specify any options for organizing imports
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            -- How code generation should act
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },
            -- If you are developing in projects with different Java versions, you need
            -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
            -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            -- And search for `interface RuntimeOption`
            -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-19",
                        path = home .. "/.asdf/installs/java/openjdk-19.0.2",
                    },
                    {
                        name = "JavaSE-11",
                        path = home .. "/.asdf/installs/java/openjdk-11.0.2",
                    },
                }
            }
        }
    },
    -- cmd is the command that starts the language server. Whatever is placed
    -- here is what is passed to the command line to execute jdtls.
    -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    -- for the full list of options
    cmd = {
        home .. "/.asdf/installs/java/openjdk-19.0.2/bin/java",
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx4g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        -- If you use lombok, download the lombok jar and place it in ~/.local/share/eclipse
        '-javaagent:' .. home .. '/.local/share/eclipse/lombok.jar',

        -- The jar file is located where jdtls was installed. This will need to be updated
        -- to the location where you installed jdtls
        '-jar', vim.fn.glob('/usr/local/Cellar/jdtls/1.21.0/libexec/plugins/org.eclipse.equinox.launcher_*.jar'),

        -- The configuration for jdtls is also placed where jdtls was installed. This will
        -- need to be updated depending on your environment
        '-configuration', '/usr/local/Cellar/jdtls/1.21.0/libexec/config_mac',

        -- Use the workspace_folder defined above to store data for this project
        '-data', workspace_folder,
    },
}


--[[
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }


local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})
*/
]]--
