return {
  -- editor 下方的狀態欄
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        opts = {
            -- NOTE: lualine reads the theme from `options.theme`. A top-level
            -- `theme` key is silently ignored.
            options = {
                theme = "tokyonight",
                -- theme = "catppuccin",
            },
        },
    },

  -- editor 上方檔案的 directory 順序
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = "tokyonight",
            -- theme = "catppuccin",
        },
    },

    {
        'akinsho/bufferline.nvim',
        event = "VeryLazy",
        version = "*",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require("bufferline").setup()
            vim.opt.termguicolors = true
        end
    },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  -- event = "VeryLazy",
  --   main = "ibl",
  --   ---@module "ibl"
  --   ---@type ibl.config
  --   opts = {},
  -- },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
                virt_text_priority = 100,
                use_focus = true,
            },
        },
    },
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        config = function()
            require('illuminate').configure()
        end
    },
    {
        "goolord/alpha-nvim",
        dependencies = {
            -- 'echasnovski/mini.icons',
            'nvim-tree/nvim-web-devicons',
        },
        config = function ()
            local status_ok, alpha = pcall(require, "alpha")

            if not status_ok then
                return
            end

            local plugins_count = require("lazy").stats().count

            local dashboard = require("alpha.themes.dashboard")

            dashboard.section.header.val = {
            "                      *((##*                                                      ",
            "                  /###%%#%&&&%,                           .%((//(/.              ",
            "                  #%%&&&&@@@@@@@*                        #%#&%@&%%##%%            ",
            "                 &&&@@@@@@@@@@@@@   .**(/(,*,/,*,       &@@@@@@@@@&&%%%*          ",
            "                 @@@@@@@@@@&@*                         %@@@@@@@@@@@@&&&&          ",
            "                  @@@@%/,               ,                 /@&%@@@@@@@&&&*         ",
            "                   &@,                 .                      /%@@@@@@@&.         ",
            "                .(..                  ,                         *#@@@@@#          ",
            "              .(                                                 .@@@@*           ",
            "              #                                                    (              ",
            "             ,             *%@%             .@@@@&*                 ,             ",
            "          *            /@@@@@@&            @@@@@@@@&                .*           ",
            "          ,            @@@@@@@@,   ...  .   .@@@@@@@@@                 /          ",
            "          /           @@@@@@/                  *&@@@@@&                           ",
            "         /           ,@&@@@.    %@@@@@@@@@,     .#@@@&&                 ,         ",
            "         #            (%%%/    *@@@@@@@@@%*      *&%#(*                 /         ",
            "         *        .     .           /                   , .,.                     ",
            "          .                /                     *                      *         ",
            "          *                #.    ./%,%/.      ,%                       /..        ",
            "          .,                                                        ,,*  *        ",
            "            %*                                 (%%#%%(,          *&*..    ,       ",
            "           ,/**#@%,**         ........ ...    #&&&@&&&%%%&(,#@@@@@&##%(%%#,,.     ",
            "          .%@@@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@@(@@@@@@&&@@%&%%&&&#@@@@@@@@&&&%(,    ",
            "          (%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.@@@@@@@@@@@@@@@&&%&@%&@@@@@@@@@%#,   ",
            "        *&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/@@@@@@@@@@@@@@@@@@@@&%&&*&@@@@@@&&#.  ",
            "        &@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/@@@@@@@@@@@@@@@@@@@@@&@@@&&(@@@@@@&%* ",
            "      .#@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@%@@@(@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@##@@@@#.",
            "      /@@@@@@@@@@@%%&%@&##%&#%/(@(&#%%###%&%@/@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&/",
            "     @@@@@@@@@@%((/((**,.,,,,*,,.,*.*.,*,,,,.. @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/",
            "    .@@@@@@@@@/.*   .                           @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(",
            }

            dashboard.section.buttons.val = {
                dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
                dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
                dashboard.button("m", "  BookMarks", ":Telescope marks <CR>"),
                dashboard.button("e", "  Extensions ", ":e ~/.config/nvim/lua/plugins<CR>"),
                dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
                dashboard.button("c", "  Configuration", ":e ~/.config/nvim/lua/settings/init.lua<CR>"),
                dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
            }

            dashboard.section.footer.val = {
                "",
                "--   ibearsNeovim Loaded " .. plugins_count .. " plugins    --",
                "",
            }

            dashboard.section.footer.opts.hl = "Type"
            dashboard.section.header.opts.hl = "Include"
            dashboard.section.buttons.opts.hl = "Keyword"

            dashboard.opts.opts.noautocmd = true
            -- vim.cmd([[autocmd User AlphaReady echo 'ready']])
            alpha.setup(dashboard.opts)
        end
    },
}
