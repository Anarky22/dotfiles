return {
  {
    "nvim-lua/popup.nvim"
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "vintharas/telescope-codesearch.nvim",
        url = "sso://user/vintharas/telescope-codesearch.nvim",
        keys = {
          {"<leader>ss", "<cmd>Telescope codesearch find_files<cr>", desc = "Codesearch Find Files"},
          {"<leader>sd", "<cmd>Telescope codesearch find_query<cr>", mode = {'n', 'v'}, desc = "Codesearch Find Query"},
          {"<leader>sD",
            function() 
              require("telescope").extensions.codesearch.find_query{default_text_expand="<cword>"}
            end,
            desc = "Codesearch find query under cursor"},
          {"<leader>sS",
            function()
              require("telescope").extensions.codesearch.find_files{default_text_expand="<cword>"}
            end,
            desc = "Codesearch find file under cursor"},
        },
        config = function()
          require("telescope").load_extension("codesearch")
        end
      },
    },
    opts = {
      defaults =  {
        -- The vertical layout strategy is good to handle long paths like those in
        -- google3 repos because you have nearly the full screen to display a file path.
        -- The caveat is that the preview area is smaller.
        layout_strategy = 'vertical',
        -- Common paths in google3 repos are collapsed following the example of Cider
        -- It is nice to keep this as a user config rather than part of
        -- telescope-codesearch because it can be reused by other telescope pickers.
        path_display = function(opts, path)
          -- Do common substitutions
          path = path:gsub("^/google/src/cloud/[^/]+/[^/]+/google3/", "google3/", 1)
          path = path:gsub("^google3/java/com/google/", "g3/j/c/g/", 1)
          path = path:gsub("^google3/javatests/com/google/", "g3/jt/c/g/", 1)
          path = path:gsub("^google3/third_party/", "g3/3rdp/", 1)
          path = path:gsub("^google3/", "g3/", 1)

          -- Do truncation. This allows us to combine our custom display formatter
          -- with the built-in truncation.
          -- `truncate` handler in transform_path memoizes computed truncation length in opts.__length.
          -- Here we are manually propagating this value between new_opts and opts.
          -- We can make this cleaner and more complicated using metatables :)
          local new_opts = {
            path_display = {
              truncate = true,
            },
            __length = opts.__length,
          }
          path = require('telescope.utils').transform_path(new_opts, path)
          opts.__length = new_opts.__length
          return path
        end,
      },
      extensions = { -- this block is optional, and if omitted, defaults will be used
        codesearch = {
          experimental = true           -- enable results from google3/experimental
        }
      }
    },
    keys = {
      {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files"},
      {"<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep"},
      {"<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffer Search"},
      {"<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags"},
      {"<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc="Current Buffer Fuzzy Find"},
    }
  },
  -- {
  --   "junegunn/fzf.vim",
  --   dependencies = {
  --     "junegunn/fzf"
  --   },
  --   lazy = false,
  --   keys = {
  --     {"<leader>zf", ":Files<CR>"}
  --     {"<leader>zb", ":Buffers<CR>"}
  --   }
  -- },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      disable_filetype = {"TelescopePrompt", "vim"},
    },
  },
  {
    "tpope/vim-repeat",
  },
}
