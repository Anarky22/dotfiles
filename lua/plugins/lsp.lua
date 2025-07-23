return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config['ciderlsp'] = {
              cmd = { '/google/bin/releases/cider/ciderlsp/ciderlsp', '--tooltag=nvim-lsp', '--noforward_sync_responses' };
              filetypes = { "c", "cpp", "java", "kotlin", "objc", "proto", "textproto", "go", "python", "bzl", "typescript", "typescript", "javascript", "soy", "scss", "soy" },
        root_markers = {".citc"},
        offset_encoding = "utf-8",
        settings = {},
      }
      vim.lsp.enable("ciderlsp")

      local table_contains = function(tbl, value)
        for _, v in pairs(tbl) do
          if v == value then
            return true
          end
        end
        return false
      end

      local on_attach = function(client, bufnr)
          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
          if vim.lsp.formatexpr then -- Neovim v0.6.0+ only.
          vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr")
          end
          if vim.lsp.tagfunc then
          vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
          end

          local opts = { noremap = true, silent = true }
          vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cd", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

          local lsp_group = vim.api.nvim_create_augroup("LSP", { clear = true })
          if client.server_capabilities.documentFormattingProvider and not table_contains({"proto", "bzl", "scss", "typescript"}, vim.bo.filetype) then
            vim.api.nvim_create_autocmd("CursorHold", {
              pattern = "<buffer>",
              group = lsp_group,
              callback = function(ev)
                vim.lsp.buf.document_highlight()
              end,
            })
            vim.api.nvim_create_autocmd("CursorHoldI", {
              pattern = "<buffer>",
              group = lsp_group,
              callback = function(ev)
                vim.lsp.buf.document_highlight()
              end,
            })
            vim.api.nvim_create_autocmd("CursorHoldI", {
              pattern = "<buffer>",
              group = lsp_group,
              callback = function(ev)
                vim.lsp.util.buf_clear_references()
              end,
            })
          end
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          on_attach(client, args.buf)
        end
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "onsails/lspkind.nvim",
    },
    opts = function()
      local lspkind = require("lspkind")
      local cmp = require("cmp")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      return {
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.close(),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                      if #cmp.get_entries() == 1 then
                          cmp.confirm({ select = true })
                      else 
                          cmp.select_next_item()
                      end
                  elseif vim.fn["vsnip#available"](1) == 1 then
                      feedkey("<Plug>(vsnip-expand-or-jump)", "")
                  elseif has_words_before() then
                      cmp.complete()
                      if #cmp.get_entries() == 1 then
                          cmp.confirm({ select = true })
                      end 
                  else
                      fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                  end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            end
          end, { "i", "s" }),
        }),

        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "vim_vsnip" },
          { name = "buffer",   keyword_length = 5 },
          { name = 'nvim_ciderlsp' },
        },

        sorting = {
          comparators = {}, -- We stop all sorting to let the lsp do the sorting
        },

        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },

        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            maxwidth = 40, -- half max width
            menu = {
              buffer = "[buffer]",
              nvim_lsp = "[CiderLSP]",
              nvim_lua = "[API]",
              path = "[path]",
              vim_vsnip = "[snip]",
              nvim_ciderlsp = "[ML-Autocompletion]"
            },
          }),
        },

        experimental = {
          native_menu = false,
          ghost_text = true,
        },
      }
    end,
  },
  {
    "folke/trouble.nvim",
    keys = {
      {"<leader>xw", "<Cmd>Trouble<CR>"},
      {"<leader>xx", "<Cmd>Trouble diagnostics toggle<CR>"},
      {"<leader>xx", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>"},
      {"<leader>xd", "<Cmd>Trouble filter.buf=0<CR>"},
      {"<leader>xl", "<Cmd>Trouble loclist<CR>"},
      {"<leader>xq", "<Cmd>Trouble quickfix<CR>"},
    }
  },
}
