-- if true then return {} end

return {
  -- 文字主題
  {
    "folke/tokyonight.nvim",
    lazy = false,
    main = "tokyonight",
    priority = 1000,
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
	  },
    init = function()
      vim.cmd("colorscheme tokyonight") -- you still must apply the colorscheme manually
    end
  },

  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   init = function()
  --     vim.cmd("colorscheme catppuccin-mocha")
  --   end
  -- },

  -- editor 下方的狀態欄
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      theme = "tokyonight",
      -- theme = "catppuccin",
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
  }
}
