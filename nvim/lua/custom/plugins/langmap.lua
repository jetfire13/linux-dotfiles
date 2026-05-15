vim.pack.add { 'https://github.com/Wansmer/langmapper.nvim' }
require('langmapper').setup { --[[ your config ]]
}
-- translate mappings
require('langmapper').automapping { global = true, buffer = true }
