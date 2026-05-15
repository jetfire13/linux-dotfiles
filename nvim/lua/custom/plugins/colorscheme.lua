-- [[ Colorscheme ]]
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
-- 'folke/tokyonight.nvim',
-- 'rebelot/kanagawa.nvim',
-- 'NTBBloodbath/doom-one.nvim',
-- 'EdenEast/nightfox.nvim',

vim.pack.add { 'https://github.com/jetfire13/vim-paper' }

-- require('tokyonight').setup {
--     styles = {
--         comments = { italic = false }, -- Disable italics in comments
--     },
-- }

-- Load the colorscheme here.
-- vim.cmd.colorscheme 'tokyonight-night'
-- vim.cmd.colorscheme 'kanagawa-wave'
-- vim.cmd.colorscheme 'kanagawa-lotus'
-- vim.cmd.colorscheme 'catppuccin-latte'
vim.cmd.colorscheme 'paper'

-- You can configure highlights by doing something like
-- vim.cmd.hi 'Comment gui=none'
