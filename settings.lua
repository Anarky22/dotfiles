-- Clipboard
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

--Indent Blankline
require('ibl').setup();

-- Treesitter
require('tree-sitter-cpp-google').setup()

require('nvim-treesitter.configs').setup {
    auto_install = true,
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
    highlight_current_scope = {
      enable = true,
    },
  },
}

require('treesitter-context').setup {
  multiline_threshold = 1,
}

require('googlepaths').setup()

-- Telescope
require('telescope').setup {
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
}
-- These custom mappings let you open telescope-codesearch quickly:
-- Fuzzy find files in codesearch.
vim.keymap.set('n', '<leader>ss',
  require('telescope').extensions.codesearch.find_files,
  { silent = true }
)

-- Search using codesearch queries in Normal and Visual mode.
vim.keymap.set({'n', 'v'}, '<leader>sd',
  require('telescope').extensions.codesearch.find_query,
  { silent = true }
)

-- Search for the word under cursor.
vim.keymap.set('n', '<leader>sD',
  function() require('telescope').extensions.codesearch.find_query{default_text_expand='<cword>'} end,
  { silent = true }
)

-- Search for a file having word under cursor in its name.
vim.keymap.set('n', '<leader>sS',
  function() require('telescope').extensions.codesearch.find_files{default_text_expand='<cword>'} end,
  { silent = true }
)

-- Neovim LSP
-- TODO: 0.11.0 updates this, once plugins follow suit I should update
local nvim_lsp = require('lspconfig')
local lsp_configs = require('lspconfig.configs')

-- CiderLSP
lsp_configs.ciderlsp = {
    default_config = {
        cmd = { '/google/bin/releases/cider/ciderlsp/ciderlsp', '--tooltag=nvim-lsp', '--noforward_sync_responses' };
        filetypes = { "c", "cpp", "java", "kotlin", "objc", "proto", "textproto", "go", "python", "bzl", "typescript", "typescript", "javascript", "soy", "scss", "soy" },
        offset_encoding = 'utf-8',
        root_dir = nvim_lsp.util.root_pattern('.citc');
        settings = {};
    }
}

vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Don't show matching
vim.opt.shortmess:append("c")

local lspkind = require("lspkind")
lspkind.init()

local cmp = require("cmp")

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
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
})

vim.cmd([[
  augroup CmpZsh
    au!
    autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } }
  augroup END
]])

function table_contains(tbl, value)
  for _, v in pairs(tbl) do
    if v == value then
      return true
    end
  end
  return false
end

-- 3. Set up CiderLSP
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

    vim.api.nvim_command("augroup LSP")
    vim.api.nvim_command("autocmd!")
    if client.server_capabilities.documentFormattingProvider and not table_contains({"proto", "bzl", "scss", "typescript"}, vim.bo.filetype) then
        vim.api.nvim_command("autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()")
        vim.api.nvim_command("autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()")
        vim.api.nvim_command("autocmd CursorMoved <buffer> lua vim.lsp.util.buf_clear_references()")
    end
    vim.api.nvim_command("augroup END")
end

nvim_lsp.ciderlsp.setup({
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = on_attach,
})

-- cider agent
local agent = require("cider-agent")
agent.setup({ server_name = 'ciderlsp' })
-- vim.api.nvim_set_keymap("n", "<leader>ac", function() vim.ui.input({ prompt = "Cider Chat: " .. agent.refs() .. "\n" }, agent.chat) end, {noremap = true })
vim.keymap.set("n", "<leader>ac", function() vim.ui.input({ prompt = "Cider Chat: " .. agent.refs() .. "\n" }, agent.chat) end, {noremap = true })
vim.keymap.set("n", "<leader>ae", function() vim.ui.input({ prompt = "Cider Edit: " .. agent.refs() .. "\n" }, agent.simple_coding) end, { noremap = true })
vim.keymap.set("n", "<leader>ah", function() vim.ui.input({ prompt = "Cider Complex: " .. agent.refs() .. "\n" }, agent.complex_tasks) end, { noremap = true })
vim.keymap.set("n", "<leader>ar", function() agent.clear() end, {})

-- Diagnostics
vim.diagnostic.config({ virtual_text = true })
require("trouble").setup({
  -- Set any options here from https://github.com/folke/trouble.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
})

-- Mappings
vim.api.nvim_set_keymap("n", "<leader>xw", "<Cmd>Trouble<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xx", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xd", "<Cmd>Trouble filter.buf=0<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xl", "<Cmd>Trouble loclist<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xq", "<Cmd>Trouble quickfix<CR>", { silent = true, noremap = true })
