-- Sets
vim.g.mapleader = ","
vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Remaps
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Call Rust runnables
vim.keymap.set("n", "<leader>rr", "<cmd> lua require('rust-tools').runnables.runnables()<CR>")

-- Keeps stuff focused in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<C-t>", ":NERDTreeToggle<CR>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- leader y to yank to system clipboard.
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
-- Telescope jump to definition
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>",
    { noremap = true, silent = true })

-- Telescope jump to definition in a split window
vim.api.nvim_set_keymap("n", "gds", "<cmd>lua require('telescope.builtin').lsp_definitions({ jump_type = 'vsplit' })<CR>"
    , { noremap = true, silent = true })



-- Plugins
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use('tpope/vim-fugitive')

    use 'neovim/nvim-lspconfig'
    use 'simrat39/rust-tools.nvim'

    local opts = {
        tools = {
            executor = require("rust-tools.executors").termopen,
            runnables = {
                use_telescope = true,
            },
            autosethints = true,
            inlay_hints = { show_parameter_hints = true },
            hover_actions = { auto_focus = true }
        },
        server = {
            settings = {
                ["rust-analyzer"] = {
                    lens = {
                        enable = true,
                    },
                    checkonsave = {
                        command = "clippy",
                    },
                },
            },
        },
    }
    require('rust-tools').setup(opts)
    require('rust-tools').inlay_hints.enable()
    require('rust-tools').runnables.runnables()

    use { 'stevearc/dressing.nvim' }

    use 'scrooloose/nerdtree'

    use 'github/copilot.vim'

    use({
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            require("rose-pine").setup({
                dark_variant = 'moon',
                disable_italics = true,
                bold_vert_split = false,
                disable_float_background = true,
                disable_background = false,
                dim_nc_background = true
            })
        end,
    })

    use "EdenEast/nightfox.nvim"
    use { "ellisonleao/gruvbox.nvim" }
    use {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    }

    -- Signs for git
    require('gitsigns').setup()

    use 'j-hui/fidget.nvim'

    use {
        "klen/nvim-test",
        config = function()
            require('nvim-test').setup()
        end
    }

    use 'jose-elias-alvarez/null-ls.nvim'
    use 'sainnhe/gruvbox-material'

    -- use { 'sthendev/mariana.vim', run='make' }

    require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = true,
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "soft", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
    })

    use({
        "neanias/everforest-nvim",
        -- Optional; default configuration will be used if setup isn't called.
        config = function()
            require("everforest").setup()
        end,
    })

    -- Github integration
    require('litee.lib').setup()
    require('litee.gh').setup({
        -- deprecated, around for compatability for now.
        jump_mode             = "invoking",
        -- remap the arrow keys to resize any litee.nvim windows.
        map_resize_keys       = false,
        -- do not map any keys inside any gh.nvim buffers.
        disable_keymaps       = false,
        -- the icon set to use.
        icon_set              = "default",
        -- any custom icons to use.
        icon_set_custom       = nil,
        -- whether to register the @username and #issue_number omnifunc completion
        -- in buffers which start with .git/
        git_buffer_completion = true,
        -- defines keymaps in gh.nvim buffers.
        keymaps               = {
            -- when inside a gh.nvim panel, this key will open a node if it has
            -- any futher functionality. for example, hitting <CR> on a commit node
            -- will open the commit's changed files in a new gh.nvim panel.
            open = "<CR>",
            -- when inside a gh.nvim panel, expand a collapsed node
            expand = "zo",
            -- when inside a gh.nvim panel, collpased and expanded node
            collapse = "zc",
            -- when cursor is over a "#1234" formatted issue or PR, open its details
            -- and comments in a new tab.
            goto_issue = "gd",
            -- show any details about a node, typically, this reveals commit messages
            -- and submitted review bodys.
            details = "d",
            -- inside a convo buffer, submit a comment
            submit_comment = "<C-s>",
            -- inside a convo buffer, when your cursor is ontop of a comment, open
            -- up a set of actions that can be performed.
            actions = "<C-a>",
            -- inside a thread convo buffer, resolve the thread.
            resolve_thread = "<C-r>",
            -- inside a gh.nvim panel, if possible, open the node's web URL in your
            -- browser. useful particularily for digging into external failed CI
            -- checks.
            goto_web = "gx"
        }
    })

    use {
        'ldelossa/gh.nvim',
        requires = { { 'ldelossa/litee.nvim' } }
    }

    vim.cmd [[let g:gruvbox_material_background = 'soft']]
    vim.cmd([[ colorscheme gruvbox-material]])

    if packer_bootstrap then
        require('packer').sync()
    end
end)
