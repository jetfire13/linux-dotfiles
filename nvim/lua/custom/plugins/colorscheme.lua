return { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
    -- 'folke/tokyonight.nvim',
    -- 'rebelot/kanagawa.nvim',
    -- 'NTBBloodbath/doom-one.nvim',
    -- 'EdenEast/nightfox.nvim',
    'yorickpeterse/vim-paper',
    -- 'catppuccin/nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        -- vim.cmd.colorscheme 'tokyonight-night'
        -- vim.cmd.colorscheme 'kanagawa-wave'
        -- vim.cmd.colorscheme 'kanagawa-lotus'
        -- vim.cmd.colorscheme 'catppuccin-latte'
        vim.cmd.colorscheme 'paper'

        -- You can configure highlights by doing something like
        vim.cmd.hi 'Comment gui=none'
    end,
}
