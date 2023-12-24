-- update the LSP server after selection
require('swenv').setup({
    post_set_venv = function(venv)
        vim.cmd('LspRestart')
    end,
})

vim.keymap.set({ 'n', 'v' }, '<leader>se', require('swenv.api').pick_venv, {})
