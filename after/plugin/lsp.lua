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

local null_ls = require('null-ls')

null_ls.setup({
    sources = {
        -- Replace these with the tools you have installed
        -- make sure the source name is supported by null-ls
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
        null_ls.builtins.formatting.black,
    }
})

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
