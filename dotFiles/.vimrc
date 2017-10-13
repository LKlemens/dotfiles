syntax on                 " syntax coloring
colorscheme Tomorrow-Night
set background=dark
"''''''''''''''''''
" SETS
" '''''''''''''''''
" SETS {{{
set nocompatible               " Disables Vi-compatibility
set t_Co=256
set autoindent                 " Copy indent from current line when starting a new line.
set dictionary=dict            " List of file names, separated by commas, that are used to lookup words	for keyword completion commands i_CTRL-X_CTRL-K.
set showmatch                  " When a bracket is inserted, briefly jump to the matching one.
set matchtime=2               " Tenths of a second to show the matching bracket.
set mousehide
set relativenumber             " Show the line number relative to the line with the cursor in front of each line.
set number                     " Precede each line with its line number.
set hidden                     " allow buffer switching without saving"
set term=screen-256color
set clipboard=unnamedplus      " Everything  yanked in vim will go to the unnamed register, and vice versa.
set visualbell                 " Use visual bell instead of beeping.
set undolevels=1000            " Maximum number of changes that can be undone.
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
set hlsearch                " highlight searched text
set incsearch               " do incremental searching
set laststatus=2            " always show status line
set ruler                   " show the cursor position all the time
set showcmd                 " display incomplete commands
set smartindent              " automatically inserts one extra level of
set guifont=Monospace\ 8        " set GUI font
set so=5                    " scrolls the text so that there are always at
set nobackup                   " Doesn't make a backup before overwriting a file.
set sessionoptions-=options    " Changes the effect of the :mksession command.
set backspace=indent,eol,start " Allow proper backspacing over special symbols.
set tags=/var/fpwork/$USER/universalTags/tags
set noswapfile                 " Disables creating swap files.
set wildmenu                   " command-line completion operates in an enhanced mode.
set wildmode=longest,list,full " Completion mode that is used for the character specified with 'wildchar'.
set smarttab                   " A <Tab> in front of a line inserts blanks according to 'shiftwidth'.
set viminfo^=%                 " Save and restore the buffer list.
set viminfo+=!  " Save and restore global variables.
set ignorecase                 " The case of normal letters is ignored.
set smartcase                  " Override the 'ignorecase' option if the search pattern contains upper case characters.
set tabpagemax=100 " Change maximum number of tabs

set splitbelow                 " Open new split panes to bottom, instead top
set splitright                 " Open new split panes to right, instead of left
set ttyfast " assume fast terminal connectio
set autoread "auto reload if file saved externally
set lazyredraw
set ttimeoutlen=100
set synmaxcol=128
syntax sync minlines=256
" }}}

" Autocmd {{{
"set cursorline
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
autocmd InsertEnter * highlight CursorLine guifg=white guibg=blue ctermfg=none cterm=bold ctermbg=darkmagenta
autocmd InsertLeave * highlight CursorLine guifg=white guibg=darkblue cterm=bold ctermfg=None ctermbg=darkblue

" Triger `autoread` when files changes on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

"cpp syntax
autocmd Syntax cpp call EnhanceCppSyntax()


" highlight ExtraWhitespace at end of line, remove them at save buffer
" ######################
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
autocmd BufWinEnter __Mundo__ call clearmatches()
autocmd BufWinEnter __Tagbar__ call EasyMode()
autocmd BufReadPost,BufWinEnter,VimEnter __Tagbar*  silent! call EasyMode()
autocmd BufWinEnter *.vimrc silent! SignifyDisable
autocmd BufWinEnter *.log HardTimeOff
autocmd BufWinEnter *.LOG HardTimeOff


"delete  redundant whitespaces
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction`

" autocmd BufWritePre     *.cpp :call TrimWhiteSpace()
" autocmd BufWritePre     *.hpp :call TrimWhiteSpace()
autocmd BufWritePre     *.ttcn3 :call TrimWhiteSpace()
autocmd BufWinEnter     *.LOG :set filetype=logreview

"open file form quick fix in vsplit
autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L

" http://stackoverflow.com/questions/1551231/highlight-variable-under-cursor-in-vim-like-in-netbeans
autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))

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

"undo files
if has('persistent_undo')      "check if your vim version supports it
  set undofile                 "turn on the feature
  set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
endif


" highlight column
highlight ColorColumn ctermbg=darkgray
au CursorHold * checktime
function! EnhanceCppSyntax()
  syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
  hi def link cppFuncDef Special
endfunction


filetype plugin indent on   " automatically finds and load specific plugin
"     or indent file for known files
"


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

nnoremap 0 ^
nnoremap ^ 0
vnoremap 0 ^
vnoremap ^ 0

" Readline-style key bindings in command-line (excerpt from rsi.vim)
cnoremap        <C-A> <Home>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"

" ========================================================================================
" remap movement for wrapped lines being the same as for non-wrapped lines
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" [o ]o - Forward and backwards quickfix
nnoremap <silent> [o <esc>:cn<cr>
nnoremap <silent> ]o <esc>:cp<cr>

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

"quit file
map qq <Esc>:q<CR>



" }}}

" OTHER MAPPPINGS {{{
"open vimrc
map vv <Esc>:tabe $MYVIMRC<CR>

"spcace in normal mode
nnoremap <space> i<space><esc>


"file manager from buffer dir
map <leader>v :Lexplore %:p:h<CR>
"from termianl dir
map <leader><space> :Lexplore<CR>
"open quickfix
map <leader>co :cope<CR>

"rename variable/fun etc in file
nnoremap <silent><Leader>R :%s/\<<c-r><c-w>\>//gI<c-f>$F/i

" Save
inoremap <silent> <C-s>     <C-O>:update<cr>
nnoremap <silent> <C-s>     :update<cr>
map <leader>w :w<cr>

"Highlight more than 2 empty lines
map <leader>l  :/^\n\{3}<CR>
" Stop the highlighting for the 'hlsearch' option
map <leader><cr> :noh<CR>

nnoremap Q @q

" }}}





" Last inserted text
nnoremap g. :normal! `[v`]<cr><left>


"tags open in vertical split
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>








nmap <leader>W :call TrimWhiteSpace()<cr>

"source vimrc
nmap <leader>so :so $MYVIMRC<cr>


"change dir to current buffer dir
nnoremap <leader>cd :cd %:p:h<CR>:pwd<cr>
"show all windows
nnoremap <leader>we :Window<cr>


"get date
inoremap <F6> <C-R>=strftime("%d/%m/%Y")<CR>

nnoremap <leader>uu  :MundoToggle<CR>
"correct indentation
map <leader>at :%!column -t<CR>
"copy from cursor to end line
noremap Y y$
"open hpp/cpp in split
map <leader>h :AV<cr>
map <leader>pp :call CopyPath()<CR>
nnoremap <leader>cf :call CopyFileName()<CR>
map <leader>tl :TagbarToggle<CR>
nnoremap ,; :call ToggleEndChar(';')<CR>
"toggle wrap arguments in function
nnoremap <silent> <leader>ew :ArgWrap<CR>
" go to place of last change
nnoremap g; g;zz
nnoremap <leader>lo :source ~/.vim/logvim<CR>
nnoremap <leader>br :call BackRev()<cr>

"change word to WORD XD
inoremap <C-F> <Esc>gUiw`]a

"abbreviations
iabbr /** /************************************************************************
iabbr **/ ************************************************************************/
iabbr //- //-----------------------------------------------------------------------
cnoreabbrev ml MarkLoad LOGI
cnoreabbrev mss MarkSave
cnoreabbrev rev !/usr/bin/svn up  %:p

" path to directory where library can be found
" let g:clang_library_path='/opt/clang/x86_64/2.8-1/lib'
filetype off                  " required
"Plug-vim
call plug#begin()
" All of your Plugins must be added before the following line
" Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'
" rainbow parentheses {{{
Plug 'kien/rainbow_parentheses.vim'

"rainbow parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['red',         'firebrick3'],
    \ ]
" \ ['darkred',     'DarkOrchid3'],
" \ ['darkgray',    'DarkOrchid3'],
" \ ['gray',        'RoyalBlue3'],
" }}}
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
Plug 'simnalamburt/vim-mundo' "version control in vim
Plug 'SirVer/ultisnips' "snippets
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/neoyank.vim'
" Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
" fzf {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/Alok/notational-fzf-vim'


"open files fzf
"change dir with fzf
nnoremap <leader>gd :Cd /var/fpwork/$USER/trunk<CR>
imap <c-x><c-l> <plug>(fzf-complete-line)
inoremap <expr> <c-x><c-k> fzf#complete('cat /var/fpwork/$USER/universalTags/final')
map <C-p> :Files<cr>
"grep fzf
map <leader>ag :Ag <c-r><c-w><cr>

" Insert mode completion
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)


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
"    \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
" Files with preview
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right', '?'), <bang>0)

"ag with preview
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, '--color-path 400 --color-line-number 400',
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:wrap', '?'),
  \                 <bang>0)


" change dir through fzf
command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
  \ {'source': 'find '.(empty(<f-args>) ? '.' : <f-args>).' -type d',
  \  'sink': 'cd'}))

let g:fzf_history_dir = '/home/$USER/.local/share/fzf-history'
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '~100%' }


"end fzf
" notational fzf
let g:nv_directories = ['~/Documents/inne', '~/Documents/praca', '~/Documents/lte' ]
let g:nv_use_short_pathnames = 1
nnoremap <silent> <leader>nv :NV<CR>
" }}}

" easy motion {{{
Plug 'easymotion/vim-easymotion'

"Easy motion
"maping easy search and easy motion
nmap s <Plug>(easymotion-overwin-f2)
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" map  z/ <Plug>(easymotion-sn)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
" }}}
Plug 'takac/vim-hardtime'
Plug 'jrosiek/vim-mark' "Highlight several words in different colors simultaneously
Plug 'bgrohman/vim-bg-sessions'
" Plug 'junegunn/limelight.vim'
" bookmarks {{{
Plug 'MattesGroeger/vim-bookmarks'

"bookmarks
let g:bookmark_sign = '>>'
let g:bookmark_annotation_sign = '##'
let g:bookmark_auto_save_file = '/tmp/my_bookmarks'
let g:bookmark_highlight_lines = 1
" }}}
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
Plug 'morhetz/gruvbox' "colorscheme
" Plug 'chriskempson/base16-vim'
Plug 'junegunn/seoul256.vim'
Plug 'gmoe/vim-espresso'

Plug 'flyovergu/cu.vim' " convert between camelCase and underscoreCase.
Plug 'vim-scripts/svn_line_history.vim'
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
Plug 'zhaocai/GoldenView.Vim' "Always have a nice view for vim split windows
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'andreshazard/vim-logreview'
" Plug 'Shougo/neocomplete.vim'

"Plug unite {{{
Plug 'Shougo/neomru.vim' "mru plugin for unite
Plug 'Shougo/unite.vim'
Plug 'hewes/unite-gtags'
Plug 'Shougo/unite-outline'
Plug 'sgur/unite-qf' " unite quickfix

"mapping
noremap <leader>f <esc>:Unite -no-split buffer file_mru  <CR>
noremap <leader>t <esc>:Unite -no-split gtags/context<CR>
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

call unite#custom#profile('default', 'context', {
\   'direction': 'topleft',
\   'vertical_preview': 1,
\   'winheight': 45
\ })

let g:unite_source_grep_command='ag'
let g:unite_source_grep_recursive_opt=''
let g:unite_source_grep_default_opts =
  \ '-i --smart-case --nogroup --nocolor --ignore-dir={.git, .cabal-sandbox, .stack-work}'
" end unite

" }}}

Plug 'tommcdo/vim-exchange' "exchange words cx
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'junegunn/vim-peekaboo' " c-r macros
Plug 'ervandew/supertab'
" Plug 'majutsushi/tagbar'
" Plug 'osyo-manga/vim-over' " %s shows how it change
Plug 'tpope/vim-endwise' " add #endif etc at the end
Plug 'machakann/vim-highlightedyank'

Plug 'mhinz/vim-signify' " show svn diff
" Plug 'wellle/tmux-complete.vim'
Plug 'vim-utils/vim-interruptless' " load file automatically
Plug 'vim-utils/vim-vertical-move' " . These move a cursor 'up' or 'down' as many lines as possible without changing the cursor column [v ]v
Plug 'terryma/vim-multiple-cursors'
Plug 'paul-nechifor/vim-svn-blame'
Plug 'sk1418/HowMuch'
Plug 'osyo-manga/vim-anzu'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'tpope/vim-eunuch'
Plug 'vheon/vim-cursormode'
" Plug 'vim-scripts/ZoomWin'
" Plug 'djoshea/vim-autoread'
" Plug 'sk1418/Join' "a better (hopefully) :Join command in vim
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'kshenoy/vim-signature' " Plugin to toggle, display and navigate marks
" Plug 'pbrisbin/vim-mkdir'
" Plug 'maralla/completor.vim'
" Plug ' rhysd/committia' " more pleasant git commit
" NeoBundle 'movitto/vim-vsearch'    "moze sie przydac
call plug#end()            " required

let &path.="src/include,/usr/include/AL,/usr/include/c++/4.4.7,/home/$USER/gnuglobal/6.5.2/bin,/var/fpwork/$USER/trunk/C_Test/**,/var/fpwork/$USER/trunk/C_Application/**,/var/fpwork/$USER/trunk/lteDo/I_Interface/Application_Env/**,/var/fpwork/$USER/trunk/lteDo/I_Interface/Private/**,,"
set makeprg=make\ -C\ ../build\ -j9

"UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"


"anzu
" ========================================================================================
" set middle of screen for new searches
nmap n :call HLNext()<cr><Plug>(anzu-n-with-echo)zz
nmap N :call HLNext()<cr><Plug>(anzu-N-with-echo)zz
" statusline
set statusline+=%{anzu#search_status()}

"netrw
let g:netrw_sort_by='time'
let g:netrw_sort_direction='reverse'
let g:netrw_liststyle = 3

"gutentag
" let g:gutentags_file_list_command = "find /var/fpwork/$USER/trunk -name '*.cpp' -o -name '*.hpp' -o -name '*.h' -o -name '*.c'"
" let g:gutentags_cache_dir='/var/fpwork/$USER/universalTags'

"tagbar
let g:tagbar_width=55

"cursonmode
let cursormode_solarized_color_map = {
      \   "nlight": "#657b83",
      \   "ndark":  "#839496",
      \   "i":      "#268bd2",
      \   "v":      "#cb4b16",
      \   "V":      "#b58900",
      \   "\<C-V>": "#6c71c4",
      \ }


"golden view
let g:goldenview__enable_default_mapping = 0



"hardtime
let g:hardtime_default_on = 1
let g:hardtime_ignore_quickfix = 1


"indent
let g:indentLine_color_term = 239

"eclim
nnoremap  <leader>d :CSearch <c-r><c-w><cr>:cclose<cr>:Unite qf<cr>
nnoremap  <leader>sc :CSearchContext <c-r><c-w>
nnoremap  <leader>ch :CCallHierarchy!<cr>
" let g:SuperTabDefaultCompletionType = 'context'
let g:EclimCSearchSingleResult='split'
" let g:EclimCppValidate = 0

"mark colors
let g:mwDefaultHighlightingPalette = 'maximum'
let g:mwDefaultHighlightingNum = 15

"how much
"The scale of the result:
let g:HowMuch_scale = 2
"the engine order for auto-calculation
let g:HowMuch_auto_engines = ['bc', 'vim', 'py']


"signify
let g:signify_cursorhold_insert     = 1
let g:signify_cursorhold_normal     = 1
let g:signify_update_on_bufenter    = 0
let g:signify_update_on_focusgained = 1

nnoremap + @@
" " Neocomplete
" let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
" let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" " <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


" switch buffers fast
nnoremap <S-Left>  :bp<cr>
nnoremap <S-Right> :bp<cr>

" signify
nnoremap <leader>st :SignifyToggle<CR>
nnoremap <leader>sth :SignifyToggleHighlight<CR>


" saves effort of going to beginning of word
" nnoremap yw yiw
" nnoremap cw ciw
" nnoremap dw diw
"mundo
let g:mundo_width = 60
let g:mundo_preview_height = 40
let g:mundo_close_on_revert = 1

"colorscheme cpp highlight
let g:cpp_concepts_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1

"Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L


if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif



"tabularize
" if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a, :Tabularize /,<CR>
  nmap <Leader>a, :Tabularize /,<CR>
" endif


"add semicolon on the end
function! ToggleEndChar(charToMatch)
    s/\v(.)$/\=submatch(1)==a:charToMatch ? '' : submatch(1).a:charToMatch
endfunction

"lightline
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'filename' ], [ 'bufferline' ] ],
  \  }
  \ }



"peekaboo
let g:peekaboo_delay = 600


"polyglot cpp
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let c_no_curly_error=1

function! CopyFileName()
  let @+=expand('%:t')
endfunction

function! CopyPath()
  let @+=expand('%:p')
endfunction

" stop arrow keys from typing A B C D
map OA <up>
map OB <Down>
map OD <left>
map OC <right>

"yank highlight
map y <Plug>(highlightedyank)
let g:highlightedyank_highlight_duration = 1200


"bold functions scheme
" let g:enable_bold_font = 1

"arwrap
let g:argwrap_line_prefix = ''



"semantic colors
" nnoremap <Leader>sc :SemanticHighlightToggle<cr>

" Set vim to save the file on focus out.
au FocusLost * :wa
"==========================================================================="
" Redraw screen every time when focus gained
au FocusGained * :redraw!
"==========================================================================="







" nnoremap <left>   <c-w>>
" nnoremap <right>  <c-w><
" nnoremap <up>     <c-w>-
" nnoremap <down>   <c-w>+




function! DataMining()
  while line('.') !~ line('$')
    let w=expand("<cword>")
    echom "word" . w
    let a=system("ag -wc ". w . "expand('%h')")
    echom " num  " . a
    let a-=1
    let i=0
    while i<a
      normal *ddNpdwN
      " echom "first while " . i
      let i+=1
    endwhile

    echom "next"
    normal! n
    while 0<i
      normal! J
      " echom "second while " . i
      let i-=1
    endwhile

    normal! j0
  endwhile
endfunction

function! BackRev()
  normal x
  let prevRev=expand("<cword>")
  let prevRev-=1
  normal :q
  silent execute  "!" . "/usr/bin/svn up -r " . prevRev . "  " . expand('%:p')
  execute 'redraw!'
endfunction

function! CurrRev()
  let g:currRev=system('/usr/bin/svn info | grep Revis | sed "s/^ *//" | cut -d " " -f2')
  let g:temp=substitute(g:currRev, '\n$', '', '')
  let @p=expand('%:p')
  " system('/usr/bin/svn up -r ' . g:currRev . ' '. expand('%:p'))
  silent exe "!" . "echo Up to revision  " . g:temp
  silent execute "!" . "/usr/bin/svn diff " . expand('%:p') . " > " .  "/home/lukaszcz/backupFun/" . expand('%:t')
  silent execute "!" . "/usr/bin/svn revert " . expand('%:p')
  silent execute "!" . "/usr/bin/svn up -r" . g:temp . " " . expand('%:p')
  " normal :!/usr/bin/svn up -r =g:currRev p
  " execute "!" . "/usr/bin/svn up -r " . g:currRev . " " . expand('%:p')
  execute 'redraw!'
  " echom g:currRev
endfunction




"function! CorrectCppMacrosInCtagFile()
"   normal! gg
"   while search('^SUBSEQUENCE	\|SUBDATA	\/var\/fpwork', "W")
"     if getline('.') !~ 'define'
"       normal! 0diWf(wyi(0PF,dwi_
"     endif
"   endwhile
"   normal! gg
"   set noignorecase
"   while search('^TC_VARIATION	\|^SEQUENCE	\/var\/fpwork\|^INHERIT_TESTCASE	\|^CA_TESTCASE	\|^INHERIT_CHECK
"             \\|^INHERIT_SEQUENCE	\|^TESTCASE	\|^MESSAGES	\/var\/fpwork\|^MESSAGE	\/var\/fpwork\|^AAEU_PROCESS
"             \\|^CHECK	\|^TC_MAIN	\|^CHANNEL	\|^THREAD	\/var\/fpwork\|::SEQUENCE	\/var\/fpwork
"             \\|::MESSAGE	\/var\/fpwork\|::MESSAGES	\/var\/fpwork\|::THREAD	\/var\/fpwork', "W")
"     if getline('.') !~ 'define'
"       normal! 0diWf(wye0P
"     endif
"   endwhile
"   normal! gg
"   while search('^SendMsg	\|^RecvMsg	', "W")
"     normal! 0diwf^wwye0P
"   endwhile
"   normal! gg
"   while search('^TEST	\|^TEST_F	\|^TEST_P	', "W")
"     if getline('.') !~ '#define\|# define'
"       normal! 0diwf(wwwye0P
"     endif
"   endwhile
"   set ignorecase
" endfunction
"
"
"
"
"function! ExpandCMacro()
"   "get current info
"   let l:macro_file_name = "__macroexpand__" . tabpagenr()
"   let l:file_row = line(".")
"   let l:file_name = expand("%")
"   let l:file_window = winnr()
"   "create mark
"   execute "normal! Oint " . l:macro_file_name . ";"
"   execute "w"
"   "open tiny window ... check if we have already an open buffer for macro
"   if bufwinnr( l:macro_file_name ) != -1
"     execute bufwinnr( l:macro_file_name) . "wincmd w"
"     setlocal modifiable
"     execute "normal! ggdG"
"   else
"     execute "bot 10split " . l:macro_file_name
"     execute "setlocal filetype=cpp"
"     execute "setlocal buftype=nofile"
"     nnoremap <buffer> q :q!<CR>
"   endif
"   "read file with gcc
"   silent! execute "r!gcc -E " . l:file_name
"   "keep specific macro line
"   execute "normal! ggV/int " . l:macro_file_name . ";$\<CR>d"
"   execute "normal! jdG"
"   "indent
"   execute "%!indent -st -kr"
"   execute "normal! gg=G"
"   "resize window
"   execute "normal! G"
"   let l:macro_end_row = line(".")
"   execute "resize " . l:macro_end_row
"   execute "normal! gg"
"   "no modifiable
"   setlocal nomodifiable
"   "return to origin place
"   execute l:file_window . "wincmd w"
"   execute l:file_row
"   execute "normal!u"
"   execute "w"
  "highlight origin line
"   let @/ = getline('.')
" endfunction
