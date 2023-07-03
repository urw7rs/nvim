local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat()
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                jedi_completion = {
                    enabled = false
                },
                black = {
                    enabled = true
                },
                ruff = {
                    enabled = true,
                    extendSelect = { "I" },
                },
                pycodestyle = {
                    enabled = false
                }
            }
        }
    }
})

lsp.setup()

-- Make sure you setup `cmp` after lsp-zero

local cmp = require('cmp')

cmp.setup({
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    }
})
