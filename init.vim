
" Vim Plug {{{
"Vim Plug - Load Plugins
"Set plugin dirrectory to ~/.local/share/nvim/plugged
call plug#begin('~/.local/share/nvim/plugged')

"Install
"Colorscheme/UI
Plug 'romainl/Apprentice', { 'branch': 'fancylines-and-neovim' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'arakashic/chromatica.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/rainbow_parentheses.vim'

"Language Specific
Plug 'wlangstroth/vim-racket'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tweekmonster/django-plus.vim'
Plug 'lervag/vimtex'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go' , { 'do': ':GoUpdateBinaries' }

"Linting/Autocomplete
"Plug 'neomake/neomake'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/deoplete-clangx'
Plug 'zchee/deoplete-jedi'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make' }
"Formating
Plug 'rhysd/vim-clang-format'

"File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'

"Minor helpful plugins
"Git within vim
Plug 'tpope/vim-fugitive'
"Tags
Plug 'ludovicchabant/vim-gutentags'
"Session management
Plug 'tpope/vim-obsession'
"Async build/test dispatcher
Plug 'tpope/vim-dispatch'
"sugar for unix shell commands in linux
Plug 'tpope/vim-eunuch'
"Comment stuff out
Plug 'tpope/vim-commentary'
"quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
"Insert/delete brackets, parens, quotes, in pair
Plug 'jiangmiao/auto-pairs'
"Adds support for plugin maps to .
Plug 'tpope/vim-repeat'

"Debugging - GDB in Vim
Plug 'sakhnik/nvim-gdb', {'do': './install.sh' }

"Initialize plugins
call plug#end()

" }}}

"Plug-ins {{{
"unload unneeded plugins
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

"set airline theme
let g:airline_theme='apprentice'
"powerline fonts for airline
let g:airline_powerline_fonts = 1

" vimtex set up neovim-remote
let g:vimtex_compile_progname = 'nvr'

"Enable Rainbow Parentheses
" Activation based on file type
augroup schemeBase 
  autocmd!
  autocmd FileType lisp,clojure,scheme,racket,rust RainbowParentheses
  autocmd FIleType racket setlocal commentstring=;\ %s
augroup END

"ALE
let g:ale_linters = {'cpp': ['clang', 'g++']}
"Neomake
"Use different modes depending on if the laptop is running
"on battery or not
" function! MyOnBattery()
"   return readfile('/sys/class/power_supply/AC/online') == ['0']
" endfunction

" if MyOnBattery()
"   call neomake#configure#automake('w')
" else
"   call neomake#configure#automake('nw', 1000)
" endif
"
"Chromatica
let g:chromatica#highlight_feature_level = 1

augroup chromatica
        autocmd!
        autocmd FileType c,cpp,objc,objcpp ChromaticaStart
augroup END

"enable deoplete
let g:deoplete#enable_at_startup = 1
"Change clang binary path
call deoplete#custom#var('clangx', 'clang_binary', '/usr/local/bin/clang')

" Change clang options
call deoplete#custom#var('clangx', 'default_c_options', '')
call deoplete#custom#var('clangx', 'default_cpp_options', '')

"Set up rust completion
let g:deoplete#sources#rust#racer_binary='/usr/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/usr/src/rust/src'
let g:deoplete#sources#rust#show_duplicates=1

"Set up go completion
let g:deoplete#sources#go#gocode_binary='/home/neil/go/bin/gocode'

"enable vim-javacomplete2
augroup javacomplete
        autocmd!
        autocmd Filetype java setlocal omnifunc=javacomplete#Complete
augroup END

"FZF
" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words')
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

"WIP
"set clang formmating options
" let g:clang_format#style_options = {
"                         \ 'AccessModifierOffset' : -4,
"                         \ 'AllowShortIfStatementsOnASingleLine' : "false",
"                         \ 'AlwaysBreakTemplateDeclarations' : "true",
"                         \ 'Standard' : "C++11" }
"autoformat code on save
" let g:clang_format#auto_format = 1

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

"}}}

"Colors {{{
""Enable 256 colors in console
set t_Co=256
"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dm

"Colorscheme
colorscheme apprentice 
"}}}

"Spaces & Tabs {{{
set tabstop=4 "number of visual spaces per TAB
set softtabstop=4 "number of spaces in tab when editing
set expandtab "tabs are spaces
set autoindent "keeps indentation same as above line
set shiftwidth=4 "number of spaces per indent

"In make files use real tabs
augroup maketab
        autocmd!
        autocmd FileType make setlocal noexpandtab
augroup END

"Fundies 2 java formatting
function SetFundiesJava()
        setlocal tabstop=2
        setlocal softtabstop=2
        setlocal textwidth=100
        setlocal shiftwidth=2
endfunction

augroup fundiesformat
        autocmd!
        autocmd FileType java call SetFundiesJava()
augroup END

augroup jsFormat
    autocmd!
    autocmd FileType javascript setlocal tabstop=2
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
"toggle vim-obsess
nnoremap <leader>s :Obsess<CR>

"turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

"open dirvish
nnoremap <leader>d :Dirvish<CR>

"Open FZF Files
nnoremap <leader>f :Files<CR>

"Open fzf buffer search
nnoremap <leader>b :Buffers<CR>

"open fzf tags search
nnoremap <leader>t :Tags<CR>

"}}}

"Keybinds {{{
"Pressing 'jj' quickly exits insert mode
:imap jj <Esc>
"Terminal mode keybinds
"<Esc> exits terminal-mode
:tnoremap <Esc> <C-\><C-n>
"}}}

"{{{ Tags
"Set tag directory to same directory as the file
set tags=./tags

"}}}

"fold all sections in .vimrc by default
"uses modeline to make it file specific
set modelines=1 
"modeline - sets it to marker and fold everything
" vim:foldmethod=marker:foldlevel=0
