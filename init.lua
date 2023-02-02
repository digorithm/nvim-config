-- Sets
vim.g.mapleader = ","
vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cmdheight = 0

vim.opt.smartindent = true

vim.opt.wrap = true

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

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Git diffview stuff
vim.keymap.set("n", "<space>gd", ":DiffviewOpen<CR>")
vim.keymap.set("n", "<space>gc", ":DiffviewClose<CR>")


-- Search and replace stuff with spectre.
vim.keymap.set("n", "<leader>sr", ":lua require('spectre').open()<CR>")

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

    use 'voldikss/vim-floaterm'

    use 'kdheepak/lazygit.nvim'

    use { "shortcuts/no-neck-pain.nvim", tag = "*" }

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
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    local wk = require("which-key")
    wk.register({
        m = {
            "<cmd>:lua require('material.functions').find_style()<CR>", "Material theme style select",
        },
        g = {
            name = "+Git",
            o = {
                name = "+Octo",
                p = { name = "+Pull Request", l = { "<cmd>Octo pr list<cr>", "List" } },
            },
        },
    }, { prefix = "<leader>" })


    -- Another github integration
    use {
        'pwntester/octo.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'kyazdani42/nvim-web-devicons',
        },
        config = function()
            require "octo".setup({
                mappings = {
                    submit_win = {
                        approve_review = { lhs = "<C-b>", desc = "approve review" },
                        comment_review = { lhs = "<C-m>", desc = "comment review" },
                        request_changes = { lhs = "<C-r>", desc = "request changes review" },
                        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
                    },
                }
            })
        end
    }

    use "rebelot/kanagawa.nvim"
    use "ajmwagar/vim-deus"
    use 'navarasu/onedark.nvim'
    use 'marko-cerovac/material.nvim'

    -- Lua
    require('onedark').setup {
        style = 'warm'
    }

    --Lua:
    vim.g.material_style = "oceanic"
    require('material').setup({
        styles = { -- Give comments style such as bold, italic, underline etc.
            comments = { italic = true },
            strings = { --[[ bold = true ]] },
            keywords = { --[[ underline = true ]] },
            functions = { --[[ bold = true, undercurl = true ]] },
            variables = {},
            operators = {},
            types = {},
        },

        plugins = { -- Uncomment the plugins that you use to highlight them
            -- Available plugins:
            "gitsigns",
            -- "nvim-tree",
            "nvim-web-devicons",
            "telescope",
            "which-key",
        },

        disable = {
            colored_cursor = false, -- Disable the colored cursor
            borders = false, -- Disable borders between verticaly split windows
            background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
            term_colors = false, -- Prevent the theme from setting terminal colors
            eob_lines = false -- Hide the end-of-buffer lines
        },

        high_visibility = {
            lighter = false, -- Enable higher contrast text for lighter style
            darker = false -- Enable higher contrast text for darker style
        },

        lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )
        custom_highlights = {
            -- Modify  diff add highlight
            DiffAdd = { bg = "#273732", },
            DiffDelete = { bg = "#3F2D32", },
            DiffChange = { bg = "#273732", },
            DiffText = { bg = "#324741", },
        }, -- Overwrite highlights
    })

    vim.cmd 'colorscheme material'

    use 'tpope/vim-fugitive'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    require('lualine').setup()

    -- Sway configuration
    -- Install Sway LSP as a custom	server
    local lspconfig = require 'lspconfig'
    local configs = require 'lspconfig.configs'

    -- Check if the config is already defined (useful when reloading this file)
    if not configs.sway_lsp then
        configs.sway_lsp = {
            default_config = {
                cmd = { 'forc-lsp' },
                filetypes = { 'sway' },
                on_attach = on_attach,
                root_dir = function(fname)
                    return lspconfig.util.find_git_ancestor(fname)
                end;
                settings = {};
            };
        }
    end

    lspconfig.sway_lsp.setup {}

    -- vim.cmd [[let g:gruvbox_material_background = 'soft']]
    -- vim.cmd([[ colorscheme gruvbox-material]])

    use 'windwp/nvim-spectre'

    -- Unless you are still migrating, remove the deprecated commands from v1.x
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

    require('neo-tree').setup {
        filesystem = {
            filtered_items = {
                visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
                hide_dotfiles = false,
                hide_gitignored = true,
            },
        },
    }

    -- toggle neo tree.
    vim.api.nvim_set_keymap("n", "<C-t>", ":Neotree<CR>", { noremap = true, silent = true })

    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

    local neogit = require('neogit')

    neogit.setup {}

    use 'christoomey/vim-tmux-navigator'

    use 'dcampos/nvim-snippy'
    use 'honza/vim-snippets'

    require('snippy').setup({
        mappings = {
            is = {
                ['<Tab>'] = 'expand_or_advance',
                ['<S-Tab>'] = 'previous',
            },
            nx = {
                ['<leader>x'] = 'cut_text',
            },
        },
    })

    -- Noice plugin
    use({
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                -- add any options here
            })
        end,
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    })

    require("noice").setup({
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
        },
    })

    if packer_bootstrap then
        require('packer').sync()
    end
end)
