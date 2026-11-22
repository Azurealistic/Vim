return {
    'S1M0N38/love2d.nvim',
    version = '3.*',
    event = 'VeryLazy',
    opts = {
        path_to_love_bin = "love.exe",
        output = false,
    },
    keys = {
        { '<leader>v',  '', desc = 'LÖVE' },
        {
            '<leader>vr',
            function()
                local root = vim.fs.root(0, { 'main.lua', 'conf.lua' }) or vim.fn.getcwd()
                local bin = require('love2d.config').options.path_to_love_bin
                vim.fn.jobstart({ 'cmd', '/c', 'start', '', bin, root }, { detach = true })
            end,
            desc = 'Run LÖVE (detached)',
        },
        { '<leader>vk', function() vim.fn.jobstart({ 'taskkill', '/IM', 'love.exe', '/F' }) end, desc = 'Kill LÖVE' },
        { '<leader>vi', '<cmd>Love info<cr>',   desc = 'Info LÖVE' },
        { '<leader>vo', '<cmd>Love output<cr>', desc = 'Output panel' },
    },
}