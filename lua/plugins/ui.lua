return {
  {
    "adisen99/apprentice.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
      "rktjmp/lush.nvim"
    },
    config = function()
      vim.opt.background = "dark"
      vim.g.apprentice_contrast_dark = "hard"
      require("lush")(require("apprentice").setup(
       {
        plugins = {
          "cmp",
          "lsp",
          "telescope",
          "treesitter",
        },
        langs = {
          "c",
          "clojure",
          "coffeescript",
          "csharp",
          "css",
          "elixir",
          "golang",
          "haskell",
          "html",
          "java",
          "js",
          "json",
          "jsx",
          "lua",
          "markdown",
          "moonscript",
          "objc",
          "ocaml",
          "purescript",
          "python",
          "ruby",
          "rust",
          "scala",
          "typescript",
          "viml",
          "xml"
        }
      }))
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = function()
      local colors = {
        almost_black = "#1c1c1c",
        darker_grey  = "#262626",
        medium_grey  = "#585858",
        lighter_grey = "#bcbcbc",
        light_purple = "#8787af",
        light_green  = "#87af87",
        green        = "#5f875f",
        light_blue   = "#87afd7",
        red          = "#af5f5f",
        orange       = "#ff8700",
        ocre         = "#87875f",
        yellow       = "#ffffaf"
      }
      local apprentice = {
        normal = {
          a = {bg = colors.ocre, fg = colors.darker_grey, gui = "bold"},
          b = {bg = colors.medium_grey, fg = colors.darker_grey},
          c = {bg = colors.darker_grey, fg = colors.lighter_grey},
        },
        insert = {
          a = {bg = colors.green, fg = colors.darker_grey, gui = "bold"},
          b = {bg = colors.medium_grey, fg = colors.darker_grey},
          c = {bg = colors.darker_grey, fg = colors.lighter_grey},
        },
        replace = {
          a = {bg = colors.red, fg = colors.darker_grey, gui = "bold"},
          b = {bg = colors.medium_grey, fg = colors.darker_grey},
          c = {bg = colors.darker_grey, fg = colors.lighter_grey},
        },
        visual = {
          a = {bg = colors.yellow, fg = colors.darker_grey, gui = "bold"},
          b = {bg = colors.medium_grey, fg = colors.darker_grey},
          c = {bg = colors.darker_grey, fg = colors.lighter_grey},
        },
        inactive = {
          a = {bg = colors.medium_grey, fg = colors.darker_grey, gui = "bold"},
          b = {bg = colors.darker_grey, fg = colors.medium_grey},
          c = {bg = colors.darker_grey, fg = colors.medium_grey},
        },
      }

      return {
        options = {
          theme = apprentice
        }
      }
    end,
  },
  {
    "simnalamburt/vim-mundo",
    lazy = false,
    config = function()
      vim.g.mundo_width = 60
      vim.g.mundo_preview_height = 20
    end,
    keys = {
      {"<leader>u", "<cmd>MundoToggle<cr>"},
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
  },
  {
    "octol/vim-cpp-enhanced-highlight",
    config = function()
      vim.g.cpp_class_scope_highlight = 1
      vim.g.cpp_member_variable_highlight = 1
      vim.g.cpp_class_decl_highlight = 1
      vim.g.cpp_posix_standard = 1
      vim.g.cpp_experimental_simple_template_highlight = 1
      vim.g.cpp_concepts_highlight = 1
    end,
  },
}
