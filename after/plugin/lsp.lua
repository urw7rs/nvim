local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- go to definition
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    -- hover
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    -- go to next diagnostic
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    -- go to previous diagnostic
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    -- view code actions
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    -- view references
    vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
    -- rename buffer
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    -- get signature help
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    lsp.buffer_autoformat()
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        -- lua
        "lua_ls",
        -- python
        "jedi_language_server", "pyright", "ruff_lsp"
    },
    handlers = {
        lsp.default_setup,
    },
})

-- (Optional) Configure lua language server for neovim
local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lspconfig.jedi_language_server.setup({
    completion = {
        resolveEagerly = true
    }
})

lspconfig.pyright.setup({
    settings = {
        pyright = {
            -- only use type checking, jedi handles completion, ruff handles imports
            disableLanguageServices = true,
            disableOrganizeImports  = true,
        }
    }
})

lspconfig.ruff_lsp.setup({
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
        }
    }
})


lsp.setup()

-- Show function signature when you type
-- require('lsp_signature').setup({})

-- Make sure you setup `cmp` after lsp-zero

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
    },
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    window = {
        -- add borders to completion menu
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})
