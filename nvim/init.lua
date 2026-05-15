-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)

do
    -- Enable faster startup by caching compiled Lua modules
    vim.loader.enable()

    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '
    vim.g.have_nerd_font = true

    -- [[ Setting options ]]
    -- See `:help vim.opt`

    -- Make line numbers default
    vim.opt.relativenumber = true
    vim.opt.number = true

    vim.opt.termguicolors = true

    -- LangMap
    local function escape(str)
        -- Эти символы должны быть экранированы, если встречаются в langmap
        local escape_chars = [[;,."|\]]
        return vim.fn.escape(str, escape_chars)
    end

    -- Наборы символов, введенных с зажатым шифтом
    local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
    local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]
    -- Наборы символов, введенных как есть
    -- Здесь я не добавляю ',.' и 'бю', чтобы впоследствии не было рекурсивного вызова комманды
    local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
    local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
    vim.opt.langmap = vim.fn.join({
        --  ; - разделитель, который не нужно экранировать
        --  |
        escape(ru_shift)
            .. ';'
            .. escape(en_shift),
        escape(ru) .. ';' .. escape(en),
    }, ',')

    --tabs & undentation
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    vim.opt.autoindent = true
    vim.opt.smartindent = true
    -- line wrapping
    vim.opt.wrap = true
    vim.opt.linebreak = true

    -- Enable mouse mode, can be useful for resizing splits for example!
    vim.opt.mouse = 'a'

    -- Don't show the mode, since it's already in status line
    vim.opt.showmode = false

    -- Sync clipboard between OS and Neovim.
    --  Schedule the setting after `UiEnter` because it can increase startup-time.
    --  Remove this option if you want your OS clipboard to remain independent.
    --  See `:help 'clipboard'`
    vim.schedule(function()
        vim.o.clipboard = 'unnamedplus'
    end)

    -- Enable break indent
    vim.opt.breakindent = true

    -- Save undo history
    vim.opt.undofile = true

    -- Case-insensitive searching UNLESS \C or capital in search
    vim.opt.ignorecase = true
    vim.opt.smartcase = true

    -- Keep signcolumn on by default
    vim.opt.signcolumn = 'yes'

    -- Decrease update time
    vim.opt.updatetime = 250

    -- Decrease mapped sequence wait time
    vim.opt.timeoutlen = 300

    -- Configure how new splits should be opened
    vim.opt.splitright = true
    vim.opt.splitbelow = true

    -- Sets how neovim will display certain whitespace in the editor.
    --  See `:help 'list'`
    --  and `:help 'listchars'`
    vim.opt.list = true
    vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

    -- Preview substitutions live, as you type!
    vim.opt.inccommand = 'split'

    -- Show which line your cursor is on
    vim.opt.cursorline = true

    -- Minimal number of screen lines to keep above and below the cursor.
    vim.opt.scrolloff = 12

    -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
    -- instead raise a dialog asking if you wish to save the current file(s)
    -- See `:help 'confirm'`
    vim.o.confirm = true

    -- Set highlight on search, but clear on pressing <Esc> in normal mode
    vim.opt.hlsearch = true

    -- [[ Basic Keymaps ]]
    --  See `:help vim.keymap.set()`
    vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

    -- Diagnostic Config & Keymaps
    --  See `:help vim.diagnostic.Opts`
    vim.diagnostic.config {
        update_in_insert = false,
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = { min = vim.diagnostic.severity.WARN } },

        -- Can switch between these as you prefer
        virtual_text = true, -- Text shows up at the end of the line
        virtual_lines = false, -- Text shows up underneath the line, with virtual lines

        -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
        jump = {
            on_jump = function(_, bufnr)
                vim.diagnostic.open_float {
                    bufnr = bufnr,
                    scope = 'cursor',
                    focus = false,
                }
            end,
        },
    }

    -- Diagnostic keymaps
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

    -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
    -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
    -- is not what someone will guess without a bit more experience.
    --
    -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
    -- or just use <C-\><C-n> to exit terminal mode
    vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

    -- TIP: Disable arrow keys in normal mode
    -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
    -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
    -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
    -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

    vim.keymap.set('n', '<tab>', '<cmd>bnext<CR>')
    vim.keymap.set('n', '<S-tab>', '<cmd>bprev<CR>')
    vim.keymap.set('n', '<C-x>', '<cmd>bdelete<CR>')

    -- Keybinds to make split navigation easier.
    --  Use CTRL+<hjkl> to switch between windows
    --
    --  See `:help wincmd` for a list of all window commands
    vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
    vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
    vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
    vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

    -- copy paste
    vim.keymap.set('v', '<C-c>', '"+y<Esc>i')
    vim.keymap.set('v', '<C-x>', '"+d<Esc>i')
    vim.keymap.set('i', '<C-v>', '"+pi')
    vim.keymap.set('i', '<C-v>', '<Esc>"+pi', { noremap = true, silent = true })
    vim.keymap.set('i', '<C-z>', '<Esc>ui', { noremap = true, silent = true })
    vim.keymap.set('i', '<C-z>', '<Esc>ui', { noremap = true, silent = true })

    -- save in insert mode
    vim.keymap.set('i', '<C-s>', '<Esc><cmd>:w<CR>', { noremap = true, silent = true })
    -- [[ Basic Autocommands ]]
    --  See `:help lua-guide-autocommands`

    -- Highlight when yanking (copying) text
    --  Try it with `yap` in normal mode
    --  See `:help vim.highlight.on_yank()`
    vim.api.nvim_create_autocmd('TextYankPost', {
        desc = 'Highlight when yanking (copying) text',
        group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
        callback = function()
            vim.highlight.on_yank()
        end,
    })
end

-- ============================================================
-- SECTION 2: PLUGIN MANAGER INTRO
-- vim.pack intro, build hooks
-- ============================================================
do
    -- [[ Intro to `vim.pack` ]]
    -- `vim.pack` is a new plugin manager built into Neovim,
    --  which provides a Lua interface for installing and managing plugins.
    --
    --  See `:help vim.pack`, `:help vim.pack-examples` or the
    --  excellent blog post from the creator of vim.pack and mini.nvim:
    --  https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
    --
    --  To inspect plugin state and pending updates, run
    --    :lua vim.pack.update(nil, { offline = true })
    --
    --  To update plugins, run
    --    :lua vim.pack.update()
    --
    --
    --  Throughout the rest of the config there will be examples
    --  of how to install and configure plugins using `vim.pack`.
    --
    --  In this section we set up some autocommands to run build
    --  steps for certain plugins after they are installed or updated.

    local function run_build(name, cmd, cwd)
        local result = vim.system(cmd, { cwd = cwd }):wait()
        if result.code ~= 0 then
            local stderr = result.stderr or ''
            local stdout = result.stdout or ''
            local output = stderr ~= '' and stderr or stdout
            if output == '' then
                output = 'No output from build command.'
            end
            vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
        end
    end

    -- This autocommand runs after a plugin is installed or updated and
    --  runs the appropriate build command for that plugin if necessary.
    --
    -- See `:help vim.pack-events`
    vim.api.nvim_create_autocmd('PackChanged', {
        callback = function(ev)
            local name = ev.data.spec.name
            local kind = ev.data.kind
            if kind ~= 'install' and kind ~= 'update' then
                return
            end

            if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
                run_build(name, { 'make' }, ev.data.path)
                return
            end

            if name == 'LuaSnip' then
                if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then
                    run_build(name, { 'make', 'install_jsregexp' }, ev.data.path)
                end
                return
            end

            if name == 'nvim-treesitter' then
                if not ev.data.active then
                    vim.cmd.packadd 'nvim-treesitter'
                end
                vim.cmd 'TSUpdate'
                return
            end
        end,
    })
end

do
    -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
    -- init.lua. If you want these files, they are in the repository, so you can just download them and
    -- place them in the correct locations.

    -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
    --
    --  Here are some example plugins that I've included in the Kickstart repository.
    --  Uncomment any of the lines below to enable them (you will need to restart nvim).
    --
    -- require 'kickstart.plugins.debug' ??
    -- require 'kickstart.plugins.indent_line'
    require 'kickstart.plugins.lint'
    require 'kickstart.plugins.autopairs'

    -- NOTE: You can add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --
    --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    require 'custom.plugins'
end

require('luasnip.loaders.from_snipmate').lazy_load { paths = './snippets' }
-- end of init.lua
