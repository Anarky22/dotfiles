" NeoVim Defaults {{{
if !has("nvim")
    set nocompatible
    syntax enable
    filetype plugin indent on
    set autoindent
    set autoread
    set backspace=indent,eol,start
    set complete-=i
    set display=lastline
    set encoding=utf-8
    set formatoptions=tcqj
    set history=10000
    set hlsearch
    set incsearch
    set langnoremap
    set laststatus=2
    set listchars=tab:>\ ,trail:-,nbsp:+
    set mouse=a
    set nrformats=hex
    set sessionoptions-=options
    set smarttab
    set tabpagemax=50
    set tags=./tags;,tags
    set ttyfast
    set viminfo+=!
    set wildmenu
endif
" }}}

" Disable ale lsp for better CoC integration - must come before plugins are
" loaded
let g:ale_disable_lsp = 1

" Vim Plug {{{
"Vim Plug - Load Plugins
"Set plugin dirrectory to ~/.local/share/nvim/plugged
call plug#begin('~/.local/share/nvim/plugged')

"Install
"Colorscheme/UI
Plug 'romainl/Apprentice', { 'branch': 'fancylines-and-neovim' }
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'bling/vim-bufferline'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

"Language Specific
Plug 'wlangstroth/vim-racket'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tweekmonster/django-plus.vim'
Plug 'lervag/vimtex'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go' , { 'do': ':GoUpdateBinaries' }
" Plug 'arakashic/chromatica.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'elixir-editors/vim-elixir'

"Linting/Autocomplete
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'dense-analysis/ale'

" Snippets
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"Formating
Plug 'rhysd/vim-clang-format'

"File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"Minor helpful plugins
"Git within vim
Plug 'tpope/vim-fugitive'
"Tags
" Plug 'ludovicchabant/vim-gutentags'
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

"Initialize plugins
call plug#end()

" }}}

"Plug-ins {{{
"unload unneeded plugins
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" NERDTree
" Close vim if last open buffer is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"set airline theme
let g:airline_theme='apprentice'
"powerline fonts for airline
let g:airline_powerline_fonts = 1
"enable tabline
let g:airline#extensions#tabline#enabled = 1

" mundo
let g:mundo_width = 60
let g:mundo_preview_height = 20

" vimtex set up neovim-remote
let g:vimtex_compile_progname = 'nvr'
let g:tex_flavor = "latex"

"Enable Rainbow Parentheses
" Activation based on file type
augroup schemeBase 
  autocmd!
  autocmd FileType lisp,clojure,scheme,racket,rust RainbowParentheses
  autocmd FIleType racket setlocal commentstring=;\ %s
augroup END

"ALE
let g:ale_echo_msg_format = '(%linter%) %s'
let g:ale_linters = {
\           'c': ['clang', 'gcc',  'ccls'],
\           'cpp': ['clang', 'g++', 'ccls']
\}
let g:ale_c_cc_options = '-Wall -Wextra -Wpedantic -std=c17'
let g:ale_c_gcc_options = '-Wall -Wextra -Wpedantic -std=c17'
let g:ale_c_clang_options = '-Wall -Wextra -Wpedantic -std=c17'
let g:ale_cpp_cc_options = '-Wall -Wextra -Wpedantic -std=c++17'
let g:ale_cpp_gcc_options = '-Wall -Wextra -Wpedantic -std=c++17'
let g:ale_cpp_clang_options = '-Wall -Wextra -Wpedantic -std=c++17'
let g:ale_pattern_options = {
\           'cs4500project': {
\               'ale_cpp_gcc_options': '-Wall -Wextra -Wpedantic -std=c++17',
\               'ale_cpp_clang_options': '-Wall -Wextra -Wpedantic -std=c++17',
\               'ale_c_gcc_options': '-std=c17 -Wall -Wextra -Wpedantic',
\               'ale_c_clang_options': '-std=c17 -Wall -Wextra -Wpedantic',
\           },
\           'CapstoneDeviceProgram': {
\               'ale_c_cc_options': '-std=c17 -Wall -Wextra -Wpedantic -I/home/neil/school/capstone/CapstoneDeviceProgram/include -I/home/neil/school/capstone/pigpio',
\               'ale_c_gcc_options': '-std=c17 -Wall -Wextra -Wpedantic -I/home/neil/school/capstone/CapstoneDeviceProgram/include -I/home/neil/school/capstone/pigpio',
\               'ale_c_clang_options': '-std=c17 -Wall -Wextra -Wpedantic -I/home/neil/school/capstone/CapstoneDeviceProgram/include -I/home/neil/school/capstone/pigpio',
\           },
\           'eece4534': {
\               'ale_c_cc_options': '-std=c89 -Wall -Wextra -Wpedantic -I/home/neil/school/eece4534/linux-4.19-zed/include',
\               'ale_c_gcc_options': '-std=c89 -Wall -Wextra -Wpedantic -I/home/neil/school/eece4534/linux-4.19-zed/include',
\               'ale_c_clang_options': '-std=c89 -Wall -Wextra -Wpedantic -I/home/neil/school/eece4534/linux-4.19-zed/include',
\           }
\}
let g:ale_pattern_options_enabled = 1
" set up airline to work with ale
let g:airline#extensions#ale#enabled = 1
" show all errors
" let g:ale_open_list = 1
" let g:ale_list_window_size = 5
" explicitly lint on save
let g:ale_lint_on_save = 1
"keep sign gutter open
let g:ale_sign_column_always = 1
"Use different modes depending on if the laptop is running
"on battery or not

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" Use arrow keys to go through errors
nmap <silent> <Up> <Plug>(ale_previous_wrap)
nmap <silent> <Down> <Plug>(ale_next_wrap)

" Chromatica
" let g:chromatica#highlight_feature_level = 1
" let g:chromatica#responsive_mode = 1
" Fix missing include on linux
" let g:chromatica#global_args = ['-isystem/usr/lib/clang/9.0.1/include']

" augroup chromatica
"         autocmd!
"         autocmd FileType c,cpp,objc,objcpp ChromaticaStart
" augroup END

" CPP Enhanced highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

" CoC settings
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>j  <Plug>(coc-format-selected)
nmap <leader>j  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Airline integration
let g:airline#extensions#coc#enabled = 1

"" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" CoC Snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

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
"                         \ 'AllowShortIfStatementsOnASingleLine' : "true",
"                         \ 'AlwaysBreakTemplateDeclarations' : "true",
"                         \ 'Standard' : "C++17" }
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

"Highlight 80 columns
set colorcolumn=80

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

function SetCLanguagesFormat()
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2
endfunction

" augroup c_cpp_format
"     autocmd!
"     autocmd FileType c,cpp call SetCLanguagesFormat()
" augroup END

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
" NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

"toggle vim-obsess
nnoremap <leader>s :Obsess<CR>

"turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

"Open FZF Files
nnoremap <leader>f :Files<CR>

"Open fzf buffer search
nnoremap <leader>b :Buffers<CR>

"open fzf tags search
nnoremap <leader>t :Tags<CR>
"Open undo tree
nnoremap <leader>u :MundoToggle<cr>

" Ale next and previous error
nnoremap <leader>e :<Plug>(ale_next_wrap)
nnoremap <leader>w :<Plug>(ale_previous_wrap)

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
