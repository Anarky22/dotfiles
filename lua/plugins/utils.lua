return {
  {
    "nvim-lua/popup.nvim"
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      defaults =  {
        -- The vertical layout strategy is good to handle long paths like those in
        -- google3 repos because you have nearly the full screen to display a file path.
        -- The caveat is that the preview area is smaller.
        layout_strategy = 'vertical',
      },
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
