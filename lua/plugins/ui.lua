return {
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
	  'kyazdani42/nvim-web-devicons',
	},
    config = function ()
      local status_ok, alpha = pcall(require, "alpha")
		if not status_ok then
			return
		end


		if vim.fn.has("win32") == 1 then
		plugins_count = vim.fn.len(vim.fn.globpath("~/AppData/Local/nvim-data/site/pack/packer/start", "*", 0, 1))
		else
		plugins_count = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))
		end

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
			dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
			dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
			dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
			dashboard.button("m", "  BookMarks", ":Telescope marks <CR>"),
		  dashboard.button("e", "  Extensions ", ":e ~/.config/nvim/lua/VisualStudioNeovim/Core/plugins.lua<CR>"),
			dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
			dashboard.button("c", "  Configuration", ":e ~/.config/nvim/lua/VisualStudioNeovim/Core/options.lua<CR>"),
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
