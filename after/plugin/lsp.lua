local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })

    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, { buffer = bufnr })


    lsp.buffer_autoformat()
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { "lua_ls", "jedi_language_server", "ruff_lsp", "clangd" },
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

lspconfig.ruff_lsp.setup({
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
        }
    }
})


lsp.setup()

-- Make sure you setup `cmp` after lsp-zero

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    }
    ,
    mapping = {
        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})
