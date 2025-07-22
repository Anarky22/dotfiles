" NeoVim Defaults {{{
if !has("nvim")
    set nocompatible
    syntax enable
    filetype plugin indent on

    set autoindent
    set autoread
    set backspace=indent,eol,start
    set belloff=all
    set backupdir=~/.vim/backup
    set complete-=i
    set cscopeverbose
    set directory=~/.vim/swap
    set display=lastline
    set encoding=utf-8
    set formatoptions=tcqj
    set nofsync
    set history=10000
    set hlsearch
    set incsearch
    set langnoremap
    set laststatus=2
    set listchars=tab:>\ ,trail:-,nbsp:+
    set mouse=a
    set nrformats=bin,hex
    set sessionoptions+=unix,slash
    set sessionoptions-=options
    set shortmess+=F
    set shortmess-=S
    set showcmd
    set sidescroll=1
    set smarttab
    set nostartofline
    set tabpagemax=50
    set tags=./tags;,tags
    set ttimeoutlen=50
    set ttyfast
    set viewoptions+=unix,slash
    set undodir=~/.vim/undo-dir
    set viminfo+=!
    set wildmenu
endif
" }}}

" Vim Plug {{{
if has('nvim')
    "Vim Plug - Load Plugins
    "Set plugin dirrectory to ~/.local/share/nvim/plugged
    call plug#begin('~/.local/share/nvim/plugged')

    "Install
    "Dependancies
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }       
    Plug 'MeanderingProgramer/render-markdown.nvim'
    
    "Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': 'TSUpdate' }    
    Plug 'nvim-treesitter/nvim-treesitter-context'
    " Plug 'nvim-treesitter/nvim-treesitter-refactor'

    "Linting/Autocomplete
    Plug 'neovim/nvim-lspconfig'
    
    " CiderLSP
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'neovim/nvim-lspconfig'
    Plug 'onsails/lspkind.nvim'

    " Diagnostics
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'folke/trouble.nvim'

    "Colorscheme/UI
    Plug 'romainl/Apprentice', { 'branch': 'fancylines-and-neovim' }
    Plug 'vim-airline/vim-airline'
    Plug 'junegunn/rainbow_parentheses.vim'
    Plug 'simnalamburt/vim-mundo'
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'lukas-reineke/indent-blankline.nvim'

    "Language Specific
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'smartpde/tree-sitter-cpp-google'

    "File Navigation
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'

    "Minor helpful plugins
    "Session management
    "Plug 'tpope/vim-obsession'
    "Async build/test dispatcher
    "Plug 'tpope/vim-dispatch'
    "sugar for unix shell commands in linux
    Plug 'tpope/vim-eunuch'
    "Comment stuff out
    Plug 'tpope/vim-commentary'
    "quoting/parenthesizing made simple
    Plug 'tpope/vim-surround'
    "Insert/delete brackets, parens, quotes, in pair
    Plug 'jiangmiao/auto-pairs'
    "devicons
    Plug 'kyazdani42/nvim-web-devicons'
    "devicons
    Plug 'kyazdani42/nvim-web-devicons'
    "Adds support for plugin maps to .
    Plug 'tpope/vim-repeat'

    "Google specific
    "Plug 'google/vim-maktaba'   
    "Plug 'google/vim-codefmt'   
    "Plug 'google/vim-glaive'   

    Plug 'sso://user/jackcogdill/nvim-figtree' 
    Plug 'sso://user/fentanes/googlepaths.nvim'
    Plug 'sso://googler@user/piloto/cmp-nvim-ciderlsp'
    Plug 'sso://user/vintharas/telescope-codesearch.nvim'
    Plug 'sso://user/idk/cider-agent.nvim'

    "Initialize plugins
    call plug#end()

    " Glug - Google Specific
    source /usr/share/vim/google/glug/bootstrap.vim

    Glug ft-soy
    Glug codefmt
    Glug codefmt-google
    Glug blaze
    Glug blazedeps plugin[mappings]
endif
" }}}

"Plug-ins {{{
"unload unneeded plugins
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
if has('nvim')
    " NERDTree
    " Close vim if last open buffer is NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    " Airline
    "set airline theme
    let g:airline_theme='apprentice'
    "powerline fonts for airline
    let g:airline_powerline_fonts = 1
    "enable tabline
    let g:airline#extensions#tabline#enabled = 1
    " Show buffer number
    let g:airline#extensions#tabline#buffer_nr_show = 1    

    " mundo
    let g:mundo_width = 60
    let g:mundo_preview_height = 20

    " vimtex set up neovim-remote
    let g:vimtex_compile_progname = 'nvr'
    let g:tex_flavor = "latex"

    "Enable Rainbow Parentheses
    " Activation based on file type
    augroup rainbowParens
        autocmd!
        autocmd VimEnter * RainbowParentheses
    augroup END

    augroup filtypeComments 
      autocmd!
      autocmd FileType racket setlocal commentstring=;\ %s
      autocmd FileType c,cpp setlocal commentstring=//\ %s
    augroup END

    " augroup schemeBase 
    "   autocmd!
    "   autocmd FileType lisp,clojure,scheme,racket,rust RainbowParentheses
    "   autocmd FIleType racket setlocal commentstring=;\ %s
    " augroup END

    " CPP Enhanced highlighting
    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight = 1
    let g:cpp_posix_standard = 1
    let g:cpp_experimental_simple_template_highlight = 1
    let g:cpp_concepts_highlight = 1

    "Add vim repeat support to vim surround
    silent! call repeat#set('\vim-surroundmap', v:count)

    "JS highlighting stuff
    let g:javascript_plugin_jsdoc = 1

    "Go Highlighting
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_types = 1
    " let g:go_auto_sameids = 1
    let g:go_fmt_command = "goimports"

  augroup autoformat_settings
    autocmd FileType borg,gcl,patchpanel AutoFormatBuffer gclfmt
    autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType c,cpp AutoFormatBuffer clang-format
    autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType go AutoFormatBuffer gofmt
    autocmd FileType java AutoFormatBuffer google-java-format
    autocmd FileType javascript,typescript,typescriptreact AutoFormatBuffer google-prettier
    " autocmd FileType javascriptreact,css,scss,html,json AutoFormatBuffer google-prettier
    autocmd FileType jslayout AutoFormatBuffer jslfmt
    autocmd FileType markdown AutoFormatBuffer mdformat
    autocmd FileType ncl AutoFormatBuffer nclfmt
    autocmd FileType proto AutoFormatBuffer protofmt
    autocmd FileType python,piccolo AutoFormatBuffer pyformat
    autocmd FileType soy AutoFormatBuffer soyfmt
    autocmd FileType sql AutoFormatBuffer format_sql
    autocmd FileType textpb AutoFormatBuffer text-proto-format
  augroup END

endif
"}}}

"{{{Lua
if has('nvim')
    luafile ~/.config/nvim/settings.lua
endif
"}}}

"GUI and Random Stuff {{{

"Backspace acts correctly
set whichwrap+=<,>,h,l

"Show Current mode
set showmode

"No sound as errors
set noerrorbells
set timeoutlen=500
set visualbell

"Save on focus loss
augroup focuslost
        autocmd!
        au FocusLost * :wa
augroup END

"Allow multiple unsaved Buffers
set hidden

"Persistant Undo - Maintain undo history between sessions
set undofile

"Highlight 100 columns
set colorcolumn=80

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved. Only bother for nvim cause plugins
if has('nvim')
    set signcolumn=yes
endif
"}}}

"Colors {{{
""Enable 256 colors in console
set t_Co=256

"Colorscheme
colorscheme apprentice 
"}}}

"Spaces & Tabs {{{
set tabstop=2 "number of visual spaces per TAB
set softtabstop=2 "number of spaces in tab when editing
set expandtab "tabs are spaces
set autoindent "keeps indentation same as above line
set shiftwidth=2 "number of spaces per indent

"In make files use real tabs
augroup maketab
    autocmd!
    autocmd FileType make setlocal noexpandtab
augroup END

" In dart use 2 spaces
" augroup twoSpace
"     autocmd!
"     autocmd FileType dart call SetTwoSpaceFormat()
" augroup END

" function SetTwoSpaceFormat()
"     setlocal tabstop=2
"     setlocal softtabstop=2
"     setlocal shiftwidth=2
" endfunction
"}}}

"UI Config {{{
"Line Numbering - hybrid in normal mode, absolute in insert mode/when buffer loses focus
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"Display current cursor line
set cursorline

"redraw only when needed
set lazyredraw

"Matching parenthesis highlighting
set showmatch
"Always have at least 2 line above and below the cursor
if !&scrolloff
        set scrolloff=2
endif
"}}}

"Folding {{{

"enable folding
set foldenable

"open most folds by default
set foldlevelstart=10

"10 nested fold max
set foldnestmax=10

"fold based on indent
set foldmethod=indent

"space opens/closes folds
nnoremap <space> za

"}}}

"Movement {{{

"move vertically by visual line
nnoremap j gj
nnoremap k gk

"highlight last inserted text
nnoremap gV '[v']

"}}}

"Leader Shortcuts {{{
"turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
"Strip trailing whitespace
nnoremap <leader>w :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

"Only bother for nvim cause plugins
if has('nvim')
    " NERDTree
    nnoremap <leader>n :NERDTreeToggle<CR>

    "toggle vim-obsess
    "nnoremap <leader>s :Obsess<CR>

    "Open FZF Files
    nnoremap <leader>zf :Files<CR>

    "Open fzf buffer search
    nnoremap <leader>zb :Buffers<CR>

    "Telescope
    nnoremap <leader>ff <cmd>Telescope find_files<cr>
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap <leader>fh <cmd>Telescope help_tags<cr>
    nnoremap <leader>/ <cmd>Telescope current_buffer_fuzzy_find<cr> 

    "Critque
    " nnoremap <leader>lc <cmd>CritiqueToggleLineComment<cr>
    " nnoremap <leader>uc <cmd>CritiqueToggleUnresolvedComments<cr>
    " nnoremap <leader>ac <cmd>CritiqueToggleAllComments<cr>
    " nnoremap <leader>fc <cmd>CritiqueFetchComments<cr>
    " nnoremap <leader>tc <cmd>CritiqueCommentsTelescope<cr>

    "open figtree
    nnoremap <leader>t :Figtree<CR>

    "Open undo tree
    nnoremap <leader>u :MundoToggle<cr>
endif


"}}}

"Keybinds {{{
"Pressing 'jj' quickly exits insert mode
:imap jj <Esc>
"Terminal mode keybinds
"<Esc> exits terminal-mode
if has('nvim')
    :tnoremap <Esc> <C-\><C-n>
endif
"}}}

"fold all sections in .vimrc by default
"uses modeline to make it file specific
set modelines=1 
"modeline - sets it to marker and fold everything
" vim:foldmethod=marker:foldlevel=0
