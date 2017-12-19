syntax on                 " syntax coloring
colorscheme apprentice
set background=dark
filetype plugin indent on   " automatically finds and load specific plugin


" SETS {{{
set nocompatible               " Disables Vi-compatibility
set t_Co=256
set cursorcolumn
set autoindent                 " Copy indent from current line when starting a new line.
set dictionary=dict            " List of file names, separated by commas, that are used to lookup words	for keyword completion commands i_CTRL-X_CTRL-K.
set showmatch                  " When a bracket is inserted, briefly jump to the matching one.
set matchtime=2               " Tenths of a second to show the matching bracket.
set mousehide
set relativenumber             " Show the line number relative to the line with the cursor in front of each line.
set number                     " Precede each line with its line number.
set hidden                     " allow buffer switching without saving"
set clipboard+=unnamedplus      " Everything  yanked in vim will go to the unnamed register, and vice versa.
set visualbell                 " Use visual bell instead of beeping.
set undolevels=9999999            " Maximum number of changes that can be undone.
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:▸
"set list to show spaces
set wrap                       " Wrap lines longer than the windows width.
set spelllang=en_us
set cursorline                 " Highlight the screen line of the cursor with CursorLine.
set expandtab               " replace tabs with spaces
set tabstop=2               " how many columns a tab counts for
set shiftwidth=2           " control how many columns text is indented with
set colorcolumn=120            " Sets colored column (this one)------------------------------------------------------->
set history=2000              " keep 50 lines of command line history
set title                      " When on, the title of the window will be set to the value of 'titlestring'.
"search
set hlsearch                " highlight searched text
set incsearch               " do incremental searching
set ignorecase                 " The case of normal letters is ignored.
set smartcase                  " Override the 'ignorecase' option if the search pattern contains upper case characters.

set laststatus=2            " always show status line
set ruler                   " show the cursor position all the time
set showcmd                 " display incomplete commands
set smartindent              " automatically inserts one extra level of
set guifont=Monospace\ 8        " set GUI font
set so=5                    " scrolls the text so that there are always at
set nobackup                   " Doesn't make a backup before overwriting a file.
set sessionoptions-=options    " Changes the effect of the :mksession command.
set backspace=indent,eol,start " Allow proper backspacing over special symbols.
" set tags=/var/fpwork/$USER/universalTags/tags
set noswapfile                 " Disables creating swap files.
set wildmenu                   " command-line completion operates in an enhanced mode.
set wildmode=longest,list,full " Completion mode that is used for the character specified with 'wildchar'.
set smarttab                   " A <Tab> in front of a line inserts blanks according to 'shiftwidth'.
set viminfo^=%                 " Save and restore the buffer list.
set viminfo+=!  " Save and restore global variables.
set tabpagemax=100 " Change maximum number of tabs

set splitbelow                 " Open new split panes to bottom, instead top
set splitright                 " Open new split panes to right, instead of left
set ttyfast " assume fast terminal connectio
set autoread "auto reload if file saved externally
set lazyredraw
set ttimeoutlen=100
set synmaxcol=128
set foldenable          " enable folding
" set foldlevelstart=10   " open most folds by default
set foldmethod=indent   " fold based on indent level
set noshowmode
syntax sync minlines=256

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python'

source $HOME/.config/nvim/plugins/hlnext.vim
source $HOME/.config/nvim/plugins/a.vim

let &path.="/usr/bin/xclip,/usr/include/c++/6.3.1"
" }}}
" MOVEMENTS {{{
" "#################################
" MAPPINGS
" ######################################
"move through splits
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" jk | Escaping!
xnoremap jk <Esc>
cnoremap jk <C-c>
inoremap jk <Esc>
inoremap kj <esc>

"change  to ,
let mapleader=','

" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap qq :q<cr>

" nnoremap 0 ^
" nnoremap ^ 0
" vnoremap 0 ^
" vnoremap ^ 0

" Readline-style key bindings in command-line (excerpt from rsi.vim)
cnoremap        <C-A> <Home>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"

" to not have to use arrow keys for recalling commands from history
cmap <C-p> <Up>
cmap <C-n> <Down>

" ========================================================================================
" remap movement for wrapped lines being the same as for non-wrapped lines
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" [w ]w - Forward and backwards tabs
nnoremap <silent> [w <esc>:tabmove -1<cr>
nnoremap <silent> ]w <esc>:tabmove +1<cr>


" ,[HJKL] - Move split
nnoremap <leader>H <C-W>H
nnoremap <leader>J <C-W>J
nnoremap <leader>K <C-W>K
nnoremap <leader>L <C-W>L

" enable hjkl in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k

"go to the begin of line
nnoremap H ^
"go to the end of line
nnoremap L $


" " stop arrow keys from typing A B C D
" map OA <up>
" map OB <Down>
" map OD <left>
" map OC <right>


" }}}
" OTHER MAPPPINGS {{{
"source vimrc
nmap <leader>so :so $MYVIMRC<cr>

"open vimrc
map vv <Esc>:tabe $MYVIMRC<CR>

"resert colorising
nnoremap <leader><esc> :syntax sync fromstart<CR>

"spcace in normal mode
nnoremap <space> i<space><esc>


"file manager from buffer dir
map <leader>v :Lexplore %:p:h<CR>
map <leader>v v:Dirvish %<CR>
"from termianl dir
map <leader><space> v:Dirvish<CR>
"open quickfix
map <leader>co :cope<CR>
map <leader>x :cclose<cr>

"rename variable/fun etc in file
nnoremap <silent><Leader>R :%s/\<<c-r><c-w>\>//gI<c-f>$F/i

"auto flake
noremap <silent><leader>af :Autoflake<cr>

" Save
inoremap <silent> <C-s>     <C-O>:update<cr>
nnoremap <silent> <C-s>     :update<cr>
map <leader>w :w<cr>

"Highlight more than 2 empty lines
map <leader>l  :/^\n\{3}<CR>
" Stop the highlighting for the 'hlsearch' option
map <leader><cr> :noh<CR>

nnoremap Q @q
nnoremap + @@

"open new tab
nnoremap <leader>t :tabnew<cr>
"open hpp/cpp in split
map <leader>h :AV<cr>

"change word to WORD XD
inoremap <C-F> <Esc>gUiw`]a

" switch quick list fast
nnoremap [q  :cp<cr>zz
nnoremap ]q :cn<cr>zz

" saves effort of going to beginning of word
" nnoremap yw yiw
" nnoremap cw ciw
" nnoremap dw diw

" Last inserted text
nnoremap g. :normal! `[v`]<cr><left>

"tags open in vertical split
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>zz
map <C-]> <C-]>zz

" nnoremap <silent> * *zz
" nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
nnoremap <silent> <C-o> <C-o>zz
nnoremap <silent> <C-i> <C-i>zz

vnoremap < <gv
vnoremap > >gv

"change dir to current buffer dir
nnoremap <leader>cd :cd %:p:h<CR>:pwd<cr>

"get date
inoremap <F6> <C-R>=strftime("%d/%m/%Y")<CR>
"correct indentation
map <leader>at :%!column -t<CR>
"copy from cursor to end line
noremap Y y$

" go to place of last change
nnoremap g; g;zz

" }}}
" Autocmd {{{
"set cursorline
" highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
" autocmd InsertEnter * highlight CursorLine guifg=white guibg=blue ctermfg=none cterm=bold ctermbg=darkmagenta
" autocmd InsertLeave * highlight CursorLine guifg=white guibg=darkblue cterm=bold ctermfg=None ctermbg=darkblue

" Triger `autoread` when files changes on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


" ale + eclim
autocmd FileType java let g:ale_java_javac_classpath=eclim#Execute('-command java_classpath -p ' . eclim#project#util#GetCurrentProjectName())

" highlight ExtraWhitespace at end of line, remove them at save buffer
" ######################
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
autocmd BufWinEnter __Mundo__ call clearmatches()
autocmd BufWinEnter __Tagbar__ call EasyMode()
autocmd BufReadPost,BufWinEnter,VimEnter __Tagbar*  silent! call EasyMode()
autocmd BufWinEnter *.vimrc silent! SignifyDisable
autocmd BufWinEnter *.log HardTimeOff
autocmd BufWinEnter *.LOG HardTimeOff
autocmd BufWinEnter *.log set colorcolumn=0
autocmd BufWinEnter *.LOG set colorcolumn=0
autocmd Filetype gitcommit setlocal spell textwidth=72

augroup vimrc
   autocmd!
   autocmd BufWinEnter,Syntax * syn sync minlines=500 maxlines=500
 augroup END

" Set vim to save the file on focus out.
au FocusLost * :wa
"==========================================================================="
" Redraw screen every time when focus gained
au FocusGained * :redraw!
"==========================================================================="

"delete  redundant whitespaces
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction`
nmap <leader>W :call TrimWhiteSpace()<cr>

autocmd BufWritePre *     :call TrimWhiteSpace()
autocmd BufWritePre     *.hpp :call TrimWhiteSpace()
autocmd BufWritePre     *.ttcn3 :call TrimWhiteSpace()
autocmd BufWinEnter     *.LOG :set filetype=logreview

"open file form quick fix in vsplit
autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L

" http://stackoverflow.com/questions/1551231/highlight-variable-under-cursor-in-vim-like-in-netbeans
" autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))

"remember the line I was on when I reopen a file
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \ exe "normal! g`\"" |
     \ endif

"commentary
autocmd FileType cpp setlocal commentstring=//\ %s

"auto source vimrc
"   autocmd bufwritepost .vimrc source $MYVIMRC

" }}}
"undo files {{{
if has('persistent_undo')      "check if your vim version supports it
  set undofile                 "turn on the feature
  set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
endif

"}}}
" highlight column  & cpp syntax{{{
highlight ColorColumn ctermbg=darkgray
au CursorHold * checktime
function! EnhanceCppSyntax()
  syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
  hi def link cppFuncDef Special
endfunction

"cpp syntax
autocmd Syntax cpp call EnhanceCppSyntax()
"}}}
"abbreviations {{{
iabbr /** /************************************************************************
iabbr **/ ************************************************************************/
iabbr //- //-----------------------------------------------------------------------
cnoreabbrev ml MarkLoad LOGI
cnoreabbrev mss MarkSave
cnoreabbrev rev !/usr/bin/svn up  %:p
" }}}
"Plug-vim {{{
filetype off                  " required
call plug#begin()
" All of your Plugins must be added before the following line
" Plug 'itchyny/vim-cursorword'
" Plug 'blueyed/vim-diminactive'
Plug 'osyo-manga/vim-brightest'
Plug 'wellle/visual-split.vim'
Plug 'hauleth/asyncdo.vim'
Plug 'haya14busa/vim-metarepeat'
" Plug 'c0r73x/neotags.nvim'
Plug 'haya14busa/vim-gtrans'
Plug 'uplus/vim-clang-rename'
Plug 'tpope/vim-commentary'
" Plug 'eapache/rainbow_parentheses.vim'
Plug 'junegunn/rainbow_parentheses.vim'

Plug 'simnalamburt/vim-mundo' "version control in vim
Plug 'SirVer/ultisnips' "snippets
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/neoyank.vim'
" Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/Alok/notational-fzf-vim' " nice flow through notations
Plug 'easymotion/vim-easymotion' " spped up motions in vim

" Plug 'takac/vim-hardtime'
Plug 'jrosiek/vim-mark' "Highlight several words in different colors simultaneously
Plug 'bgrohman/vim-bg-sessions'
Plug 'junegunn/limelight.vim'
" Plug 'duckwork/limelight.vim'
Plug 'MattesGroeger/vim-bookmarks'

Plug 'yuttie/comfortable-motion.vim' "smooth motion c-d c-u
Plug 'rhysd/clever-f.vim'
Plug 'unblevable/quick-scope' " Vim plugin that highlights which characters to target for f, F and family.

"colorschemes
Plug 'dikiaap/minimalist'
Plug 'chriskempson/tomorrow-theme'
Plug 'flazz/vim-colorschemes'
Plug 'kristijanhusak/vim-hybrid-material' "colorscheme
Plug 'tyrannicaltoucan/vim-quantum' "colorscheme
Plug 'dikiaap/minimalist' "colorscheme
" Plug 'chriskempson/base16-vim'
Plug 'junegunn/seoul256.vim'
Plug 'gmoe/vim-espresso'

Plug 'flyovergu/cu.vim' " convert between camelCase and underscoreCase.
Plug 'sickill/vim-pasta' " correct indent when pasting

"textobj
Plug 'kana/vim-textobj-function'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'

Plug 'tpope/vim-repeat' " make dot better
Plug 'wellle/targets.vim' " It expands on the idea of simple commands like di'
Plug 'FooSoft/vim-argwrap'
Plug 'Yggdroot/indentLine' "This plugin is used for displaying thin vertical lines at each indentation level for code indented with spaces
" Plug 'roman/golden-ratio' "Always have a nice view for vim split windows
Plug 'justincampbell/vim-eighties'
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'andreshazard/vim-logreview'
" Plug 'Shougo/neocomplete.vim'

Plug 'Shougo/neomru.vim' "mru plugin for unite
Plug 'Shougo/unite.vim'
Plug 'hewes/unite-gtags'
Plug 'Shougo/unite-outline'
Plug 'sgur/unite-qf' " unite quickfix


Plug 'tommcdo/vim-exchange' "exchange words cx
Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'junegunn/vim-peekaboo' " c-r macros
Plug 'ervandew/supertab'
" Plug 'majutsushi/tagbar'
" Plug 'osyo-manga/vim-over' " %s shows how it change
Plug 'tpope/vim-endwise' " add #endif etc at the end
Plug 'machakann/vim-highlightedyank'

" Plug 'mhinz/vim-signify' " show svn diff
" Plug 'wellle/tmux-complete.vim'
Plug 'vim-utils/vim-interruptless' " load file automatically
Plug 'vim-utils/vim-vertical-move' " . These move a cursor 'up' or 'down' as many lines as possible without changing the cursor column [v ]v
Plug 'terryma/vim-multiple-cursors'
Plug 'sk1418/HowMuch'
Plug 'osyo-manga/vim-anzu' " count appearances of search pattern
Plug 'jaxbot/semantic-highlight.vim'
Plug 'tpope/vim-eunuch' "Vim sugar for the UNIX shell commands that need it the most.
Plug 'vheon/vim-cursormode' " multicursor edit
" Plug 'chrisbra/NrrwRgn' "focus on a selected region while making the rest inaccessible. NRP, NRM
" Plug 'justinmk/vim-dirvish' " Directory viewer for Vim  gf / c-w f
Plug 'tpope/vim-unimpaired' " pairs of handy bracket mappings
Plug 'tmux-plugins/vim-tmux-focus-events' "FocusGained and FocusLost autocommand events are working in terminal vim now
Plug 'junegunn/vim-easy-align'
Plug 'szw/vim-maximizer'
Plug 'tenfyzhong/axring.vim' " ax enhancement c-a c-x
" Plug 'vim-scripts/ZoomWin'
" Plug 'djoshea/vim-autoread'
" Plug 'sk1418/Join' "a better (hopefully) :Join command in vim
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'kshenoy/vim-signature' " Plugin to toggle, display and navigate marks
" Plug 'pbrisbin/vim-mkdir'
" Plug 'maralla/completor.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-clang'
Plug 'Shougo/echodoc.vim'
Plug 'tenfyzhong/CompleteParameter.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'lilydjwg/colorizer' " colorized hex
Plug 'fs111/pydoc.vim' " "
Plug 'edkolev/tmuxline.vim'
"Displays git changes
Plug 'airblade/vim-gitgutter'
" Plug 'ryanoasis/vim-devicons'
Plug 'Chiel92/vim-autoformat'
Plug 'justinmk/vim-dirvish'
Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'
Plug 'rhysd/committia.vim' " more pleasant git commit
Plug 'tell-k/vim-autoflake'

"java sc
Plug 'ternjs/tern_for_vim'
Plug 'pangloss/vim-javascript'
Plug 'sheerun/vim-polyglot'
Plug 'KabbAmine/vCoolor.vim'

Plug 'alvan/vim-closetag' " Auto close (X)HTML tags

Plug 'majkinetor/unite-cmdmatch'
Plug 'terryma/vim-expand-region'
Plug 'machakann/vim-swap'
Plug 'nelstrom/vim-visual-star-search'
Plug 'jaxbot/selective-undo.vim'
Plug 'Rykka/riv.vim'
Plug 'Rykka/InstantRst'
Plug 'brooth/far.vim'
Plug 'inside/vim-search-pulse'
" NeoBundle 'movitto/vim-vsearch'    "moze sie przydac
call plug#end()            " required
" }}}
"Plugins settings {{{
" deoplete {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
" }}}
"ale {{{
" function! s:autoflake(buffer):
" endfunction
let g:ale_linters = {
      \   'c': ['gcc'],
      \   'cpp': ['g++'],
      \   'java': ['javac'],
      \   'javascript': ['eslint', 'jshint'],
      \   'python': ['yapf', 'isort', 'flake8',],
      \}

let g:ale_fixers = {
      \   'python': ['autopep8', 'isort', 'docformatter', 'yapf',]
      \}
let g:autoflake_imports="django,requests,urllib3,numpy,scipy,sklearn,pandas,tensorflow"

let g:ale_sign_error = ''
let g:ale_sign_warning = ''

let g:ale_echo_msg_error_str = 'ERROR  '
let g:ale_echo_msg_warning_str = 'WARNING  '
let g:ale_echo_msg_format = '[%severity%] [%linter%] %s'
"
" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

let g:ale_fix_on_save = 1
"}}}
" fzf {{{

"open files fzf
"change dir with fzf
nnoremap <leader>gd :Cd $HOME/studia<CR>
imap <c-x><c-l> <plug>(fzf-complete-line)
map <C-p> :Files<cr>
"grep fzf
map <leader>ag :Ag <c-r><c-w><cr>

" Insert mode completion
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <silent> <leader>nv :NV<CR>

"show all windows
nnoremap <leader>we :Window<cr>

" fzf colors like colorscheme
function! s:update_fzf_colors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['Comment',      'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['Statement',    'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code > 0
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction

augroup _fzf
  autocmd!
  autocmd VimEnter,ColorScheme * call s:update_fzf_colors()
augroup END

"FZF
" let g:fzf_files_options =
"             \ '--preview "highlight -q --force -O ansi /opt/python-pygments/noarch/2.2.0.p360-1/bin/pygmentize {} || cat {}"'
" let g:fzf_files_options =
"    \ '--preview "(/opt/python-pygments/noarch/2.2.0.p360-1/bin/pygmentize {} || cat {}) 2> /dev/null " "| head -'.&lines.'"'
" Files with preview
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right', '?'), <bang>0)

"ag with preview
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, '-w --color-path 400 --color-line-number 400',
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:wrap', '?'),
  \                 <bang>0)

" change dir through fzf
command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
  \ {'source': 'find '.(empty(<f-args>) ? '.' : <f-args>).' -type d',
  \  'sink': 'cd'}))

let g:fzf_history_dir = '$HOME/.local/share/fzf-history'
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '~100%' }


"end fzf
" notational fzf
let g:nv_directories = ['~/Documents/notes']
let g:nv_use_short_pathnames = 1

" }}}
" unite {{{
"mapping
noremap <leader>f <esc>:Unite -no-split buffer file_mru  <CR>
" noremap <leader>t <esc>:Unite -no-split gtags/context<CR>
" noremap <leader>d <esc>:Unite  gtags/def<cr>
noremap <leader>gr <esc>:Unite -no-split gtags/ref<CR>
nnoremap <leader>y :Unite history/yank<CR>
nnoremap <leader>uq :Unite -no-split qf<cr>
nnoremap <leader>ur :UniteResume<cr>
nnoremap <leader>uo :Unite -no-split outline<cr>
nnoremap <leader>gg :Unite -no-split grep:.::<c-r><c-w><cr>
cnoreabbrev ug Unite -no-split grep:.::


"Unite
let g:neoyank#limit=1000

call unite#custom#profile('source/vim_bookmarks', 'context', {
  \   'winheight': 13,
  \   'direction': 'botright',
  \   'start_insert': 0,
  \   'keep_focus': 1,
  \   'no_quit': 1,
  \ })

call unite#custom#profile('default', 'context', {
  \   'direction': 'topleft',
  \   'vertical_preview': 1,
  \   'winheight': 45
  \ })

let g:unite_source_menu_menus = {}
let g:unite_prompt = '>>> '
let g:unite_marked_icon = '✓'
let g:unite_candidate_icon = '∘'

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)

  nmap <silent><buffer><expr> Enter unite#do_action('switch')
  nmap <silent><buffer><expr> <C-t> unite#do_action('tabswitch')
  nmap <silent><buffer><expr> <C-h> unite#do_action('splitswitch')
  nmap <silent><buffer><expr> <C-v> unite#do_action('vsplitswitch')

  imap <silent><buffer><expr> Enter unite#do_action('switch')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabswitch')
  imap <silent><buffer><expr> <C-h> unite#do_action('splitswitch')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplitswitch')

  map <buffer> <C-p> <Plug>(unite_toggle_auto_preview)

  nnoremap <ESC> :UniteClose<cr>
endfunction


let g:unite_source_grep_command='ag'
let g:unite_source_grep_recursive_opt=''
let g:unite_source_grep_default_opts =
  \ '-i --smart-case --nogroup --nocolor --ignore-dir={.git, .cabal-sandbox, .stack-work}'
" end unite

" }}}
"Easy Motion {{{
"maping easy search and easy motion
nmap s <Plug>(easymotion-overwin-f2)
let g:EasyMotion_skipfoldedline = 0
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-bd-jk)
map <Leader>k <Plug>(easymotion-k)
" map  z/ <Plug>(easymotion-sn)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
" }}}
" clang rename {{{
  au FileType c,cpp nmap <buffer><silent>,lr <Plug>(clang_rename-current)
" }}}
"
" " limelight {{{
augroup FadeWindows
    au! FocusGained * Limelight!
    au! FocusLost * Limelight
    au! WinEnter * Limelight!
    au! WinLeave * Limelight
augroup END
" }}}
"
"clang type {{{
augroup clang-inspect-type-mapping
    autocmd!
    autocmd FileType cpp nmap <C-t> <Plug>(clang-inspect-type-at-cursor)
augroup END
"}}}
"far {{{
" let g:far#source = 'agnvim'
let g:far#limit = 10000
let g:far#auto_write_replaced_buffers=1
"}}}
"highlight undo {{{
" nmap u     <Plug>(highlightedundo-undo)
" nmap <C-r> <Plug>(highlightedundo-redo)
" nmap U     <Plug>(highlightedundo-Undo)
"}}}
"CompleteParameter {{{
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
inoremap <buffer><silent> ) <C-R>=AutoPairsInsert(')')<CR>
"}}}
" vim-lion {{{
let b:lion_squeeze_spaces = 1
" }}}
"UltiSnips {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
"}}}
"arwrap {{{
"toggle wrap arguments in function
nnoremap <silent> <leader>ew :ArgWrap<CR>
let g:argwrap_line_prefix = ''
" }}}
" bookmarks {{{
let g:bookmark_sign = '>>'
let g:bookmark_annotation_sign = '##'
let g:bookmark_auto_save_file = '/tmp/my_bookmarkss'
let g:bookmark_highlight_lines = 1
" }}}
"
"riv {{{
let proj1 = { 'path': '~/Documents/riv',}
let g:riv_projects = [proj1]
"}}}
"committia {{{
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    end

endfunction
"}}}
"auto close {{{
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_shortcut = '>'
"}}}
"completor {{{
let g:completor_node_binary = '/usr/bin/node'
"}}}
"ulitxnips {{{
let g:UltiSnipsExpandTrigger="<c-e>"
"}}}
"axring {{{
let g:axring_rings = [
      \ ['&&', '||'],
      \ ['&', '|', '^'],
      \ ['&=', '|=', '^='],
      \ ['>>', '<<'],
      \ ['>>=', '<<='],
      \ ['==', '!='],
      \ ['>', '<', '>=', '<='],
      \ ['++', '--'],
      \ ['true', 'false'],
      \ ['GLO_FALSE', 'GLO_TRUE'],
      \ ['verbose', 'debug', 'info', 'warn', 'error', 'fatal'],
      \ ]
"}}}
"easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"}}}
"maximizer {{{
let g:maximizer_default_mapping_key = '<leader>ma'
"}}}
" dirvish {{{
let g:dirvish_mode = ':sort ,^.*[\/],'
" }}}
" " rainbow parentheses {{{

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

augroup rainbow_lisp
  autocmd!
  autocmd FileType * RainbowParentheses
augroup END

" let g:rbpt_colorpairs = [
"     \ ['Darkblue',    'SeaGreen3'],
"     \ ['darkgreen',   'firebrick3'],
"     \ ['darkcyan',    'RoyalBlue3'],
"     \ ['darkred',     'SeaGreen3'],
"     \ ['brown',       'RoyalBlue3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['brown',       'firebrick3'],
"     \ ['black',       'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['Darkblue',    'firebrick3'],
"     \ ['darkgreen',   'RoyalBlue3'],
"     \ ['darkcyan',    'SeaGreen3'],
"     \ ['red',         'firebrick3'],
"     \ ]
" " \ ['darkred',     'DarkOrchid3'],
" " \ ['darkgray',    'DarkOrchid3'],
" " \ ['gray',        'RoyalBlue3'],
" let g:rbpt_max = 16
" let g:rbpt_loadcmd_toggle = 0
" let g:bold_parentheses = 1      " Default on
" function! Parentheses()
"    normal :RainbowParenthesesToggle
"    normal :RainbowParenthesesLoadRound
"    normal :RainbowParenthesesLoadSquare
"    normal :RainbowParenthesesLoadBraces
"   normal :RainbowParenthesesLoadChevrons
"   normal :RainbowParenthesesToggle
"   normal :RainbowParenthesesLoadRound
"   normal :RainbowParenthesesLoadSquare
"   normal :RainbowParenthesesLoadBraces
"   normal :RainbowParenthesesLoadChevrons
" endfunction
" augroup parentheses
"   au!
"   au VimEnter * RainbowParenthesesToggle
"   au Syntax * RainbowParenthesesLoadRound
"   au Syntax * RainbowParenthesesLoadSquare
"   au Syntax * RainbowParenthesesLoadBraces
"   au Syntax * RainbowParenthesesLoadChevrons
" augroup END
" " }}}
"anzu , nN search {{{
" ========================================================================================
" set middle of screen for new searches
nmap n :call HLNext()<cr><Plug>(anzu-n-with-echo)zz
nmap N :call HLNext()<cr><Plug>(anzu-N-with-echo)zz
" statusline
set statusline+=%{anzu#search_status()}
" }}}
"netrw {{{
let g:netrw_sort_by='time'
let g:netrw_sort_direction='reverse'
let g:netrw_liststyle = 3
"}}}
"tagbar {{{
" map <leader>tl :TagbarToggle<CR>
" let g:tagbar_width=55
"}}}
"cursonmode{{{
let cursormode_solarized_color_map = {
      \   "nlight": "#657b83",
      \   "ndark":  "#839496",
      \   "i":      "#268bd2",
      \   "v":      "#cb4b16",
      \   "V":      "#b58900",
      \   "\<C-V>": "#6c71c4",
      \ }
"}}}
"yank highlight {{{
map y <Plug>(highlightedyank)
let g:highlightedyank_highlight_duration = 1200
"}}}
"tmux navigate {{{
"C-h woks now !
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
"}}}
"
"lightline {{{
let g:lightline                  = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.tabline          = {}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

let g:lightline#ale#indicator_warnings = ' '
let g:lightline#ale#indicator_errors = ' '
let g:lightline#ale#indicator_ok = ' '

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [  'mode', 'paste' ], [ 'fugitive', 'filename' ]],
      \   'right': [[ 'linter_errors', 'linter_warnings', 'linter_ok' ],['percent', 'lineinfo']]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'modified': 'LightlineModified',
      \   'filename': 'LightlineFilename'
      \ },
      \ 'component_expand': {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ },
      \ 'component': {
      \   'lineinfo': ' %3l:%-2v'
      \},
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'tabline': {
      \ 'left': [ [ 'tabs' ] ]
      \},
      \ 'mode_map':{
      \ 'n' :     '  NORMAL',
      \ 'i' :     '  INSERT',
      \ 'R' :     ' REPLACE',
      \ 'v' :     ' VISUAL',
      \ 'V' :     ' V-LINE',
      \ "\<C-v>": ' V-BLOCK',
      \ 'c' :     ' COMMAND',
      \ 's' :     ' SELECT',
      \ 'S' :     ' S-LINE',
      \ "\<C-s>": ' S-BLOCK',
      \ 't': ' TERMINAL',
      \},
      \ }
" \   'bufferline': '%{bufferline#refresh_status()} %{g:bufferline_status_info.before . g:bufferline_status_info.current . g:bufferline_status_info.after}'
function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return ""
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

  function! LightlineReadonly()
    return &readonly ? '' : ''
  endfunction
  function! LightlineFugitive()
    if exists('*fugitive#head')
      let branch = fugitive#head()
      return branch !=# '' ? ''.branch : ''
    endif
    return ''
  endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
"}}}
"eighties {{{
let g:eighties_enabled = 1
let g:eighties_minimum_width = 80
let g:eighties_extra_width = 0 " Increase this if you want some extra room
let g:eighties_compute = 1 " Disable this if you just want the minimum + extra
let g:eighties_bufname_additional_patterns = ['fugitiveblame']
"}}}
"hardtime {{{
let g:hardtime_ignore_buffer_patterns = [".vimrc"]
let g:hardtime_default_on = 1
let g:hardtime_ignore_quickfix = 1
"}}}
"how much {{{
"The scale of the result:
let g:HowMuch_scale = 2
"the engine order for auto-calculation
let g:HowMuch_auto_engines = ['bc', 'vim', 'py']
"}}}
"signify {{{
let g:signify_cursorhold_insert     = 1
let g:signify_cursorhold_normal     = 1
let g:signify_update_on_bufenter    = 0
let g:signify_update_on_focusgained = 1

nnoremap <leader>st :SignifyToggle<CR>
nnoremap <leader>sth :SignifyToggleHighlight<CR>
"}}}
"mundo {{{
nnoremap <leader>uu  :MundoToggle<CR>

let g:mundo_width = 60
let g:mundo_preview_height = 40
let g:mundo_close_on_revert = 1
" }}}
"colorscheme cpp highlight {{{
let g:cpp_concepts_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
"}}}
"
"autoflake {{{
" THERES IS ADDITIONAL AUTOFLAKE VIM PLUGIN RUNNING POST WRITE
let g:autoflake_disable_show_diff=1
let g:autoflake_remove_unused_variables=1
"}}}
" tmuxline {{{
let g:tmuxline_preset = {
      \'a'       : '#S',
      \'win'     : '#I.#W',
      \'cwin'    : '#I.#W',
      \'y'       : [' #(uptime | grep -PZo "(?<=up )[^,]*")'],
      \'z'       : ['%R', '%a', '%Y'],
      \'options' : {'status-justify' : 'left'}}
" }}}
"githutter {{{
set updatetime=250
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified = ' '
let g:gitgutter_sign_modified_removed = ' '
"}}}
"autoformat {{{
let g:formatdef_my_cpp = '"clang-format -style=Google"'
let g:formatters_cpp = ['my_cpp']
" }}}
"golden ratio {{{
let g:golden_ratio_filetypes_blacklist = ["unite", "netrw", "__Mundo__", "__Mundo_Preview__", "diff"]
"}}}
"semantic colors {{{
" nnoremap <Leader>sc :SemanticHighlightToggle<cr>
"}}}
"peekaboo {{{
" let g:peekaboo_delay = 600
"}}}
"indent {{{
let g:indentLine_color_term = 239
"}}}
"mark colors {{{
let g:mwDefaultHighlightingPalette = 'maximum'
let g:mwDefaultHighlightingNum = 15
"}}}
"}}}
"python {{{
noremap <leader>rp :!python2 %
"}}}
"eclim {{{
nnoremap   <leader>i :JavaImportOrganize<cr>
nnoremap   <leader>d :JavaDocSearch <cr>
nnoremap   <leader>js :JavaSearch <cr>
nnoremap   <leader>jf :%JavaFormat<cr>
nnoremap   <leader>jc :JavaCorrect<cr>
nnoremap   <leader>jim :JavaImpl<cr>
"
"
let g:EclimCompletionMethod = 'omnifunc'
" let g:SuperTabDefaultCompletionType = 'context'
let g:EclimJavaSearchSingleResult='vsplit'
let g:EclimCValidate = 0
let g:EclimJavaValidate = 0
"}}}
"my functions {{{
"add semicolon on the end function {{{
nnoremap ,; :call ToggleEndChar(';')<CR>
function! ToggleEndChar(charToMatch)
    s/\v(.)$/\=submatch(1)==a:charToMatch ? '' : submatch(1).a:charToMatch
endfunction
"}}}
"DiffOrig {{{
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif
"}}}
"copy path/file name {{{
map <leader>pp :call CopyPath()<CR>
nnoremap <leader>cf :call CopyFileName()<CR>
function! CopyFileName()
  let @+=expand('%:t')
endfunction

function! CopyPath()
  let @+=expand('%:p')
endfunction
"}}}
" }}}
