""
"" Settings common between vim and neovim
""

"" Common corrections:
" Virtual Edit
" set ve=none


syntax on
filetype plugin indent on


""
"" Basic Setup
""

"""" Copied from Janus core settings

set nocompatible      " Use vim, no vi defaults
"set number            " Show line numbers
set ruler             " Show line and column number
syntax enable         " Turn on syntax highlighting allowing local overrides
set encoding=utf-8    " Necessary to show unicode glyphs
set laststatus=2      " Always show the statusline

set pastetoggle=<F3>
let mapleader = "'"

""
"" Whitespace
""

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

if exists("g:enable_mvim_shift_arrow")
  let macvim_hig_shift_movement = 1 " mvim shift-arrow-keys
endif

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen
"hi Whitespace ctermfg=red ctermbg=red guibg=white guifg=gray


""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

" Toggle hl search
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" Search without moving page
nnoremap <Leader>/ :set hlsearch<CR> :let @/=""<Left>

" Search and highlight without jumping https://stackoverflow.com/a/4257175
"nnoremap * *``
nnoremap * :keepjumps normal! mi*`i<CR>

" to blink highlight next search (in milliseconds)
nnoremap <silent>n n:call HLNext(100)<CR>
nnoremap <silent>N N:call HLNext(100)<CR>

function! HLNext (blinktime)
  "let l:matchCount = {execute '%s/' . getreg('/') . '//n'}
  "echon '-- Searching' .. l:matchCount .. '--'
  set invcursorline
  redraw
  exec 'sleep ' . float2nr(a:blinktime) . 'm'
  set invcursorline
  redraw
endfunction


""
"" Locate Cursor
""
function! LocateCursor ()
  set invcursorline
  redraw
  exec 'sleep 200m'
  set invcursorline
  redraw
endfunction
nnoremap <leader>l :call LocateCursor()<CR>
nnoremap <leader>; :call LocateCursor()<CR>


"""
""" Different color cursors per state
"""
"" Doesn't seem to work in neovim (different type of colors perhaps?)
"" TODO change the color back to black when exiting so it doesn't stick in the terminal.
"if &term =~ "xterm\\|rxvt"
"  " use an orange cursor in insert mode
"  silent! let &t_SI = "\e[5 q\e]12;orange\x7"
"  " use a red cursor in replace mode
"  silent! let &t_SR = "\e[3 q\e]12;red\x7"
"  " use a green cursor otherwise
"  silent! let &t_EI = "\e[2 q\e]12;green\x7"
"  silent !echo -ne "\033]12;green\007"
"endif


""
"" Wild settings
""

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

""
"" Backup and swap files
""

set backupdir^=~/.vim/_backup//    " where to put backup files.
set directory^=~/.vim/_temp//      " where to put swap files."

"""" Thanks Janus :)


" UltiSnip Config
let g:UltiSnipsExpandTrigger       = "<c-j>"
" let g:UltiSnipsListSnippets        = "<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetsDir         = "~/.vim/UltiSnips"

" Enable smart tabs
"let g:airline#extensions#tabline#enabled = 1


" -- Python --
" Python only 2 space indention
au FileType python set softtabstop=2 | set shiftwidth=2 | set softtabstop=2

"""""""""""""" Colors """"""""""""""
"" Setup Solarized
"let g:solarized_visibility = 'high'
"set background=dark
"colorscheme solarized
"call togglebg#map("<F5>")

colorscheme fogbell_light
"colorscheme fogbell

" Fix ugly SignColumn particularly when using gitgutter
highlight clear SignColumn
autocmd ColorScheme * highlight clear SignColumn

nmap <leader>cfd :colorscheme fogbell<CR>
nmap <leader>cfl :colorscheme fogbell_light<CR>
nmap <leader>cfi :colorscheme fogbell_lite<CR>
nmap <leader>cd  :colorscheme default<CR>
nmap <leader>csd :colorscheme solarized<CR>

""
"" Vim Illuminate
""
" Make vim-illuminate work again
set termguicolors


" Enable Mouse for when I'm feeling lazy
if has("mouse")
  set mouse=a
  " set mousehide
endif

"if has("mouse_sgr")
  "set ttymouse=sgr
"else
  "set ttymouse=xterm2
"end

set noshowmode " Hide the default mode text, powerline already does

set colorcolumn=80,120

" Keep cursor from edge
set sidescroll=1
set sidescrolloff=5
set scrolloff=5

"""" MAPPINGS

" Fugitive
nmap <leader>gs :Git<CR>
" git add current file
nmap <leader>ga :Git add %:p<CR>
"set previewheight=20

" Text Bubbling
" Bubble single lines
nmap <C-k> [e
nmap <C-j> ]e
" Bubble multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv


""
"" NerdTree
""
"map <leader>n :NERDTreeToggle<CR>
"map <leader>nf :NERDTreeFind<CR>
map <leader>n :NERDTreeFind<CR>
"map <leader><leader>n :NERTreeMirror<CR>:NERDTreeToggle<CR> " Not working
map <leader><leader>n :NERDTreeToggle<CR>

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
      \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif | wincmd p

" Open the existing NERDTree on each new tab.
" TODO only if nerdtree was open before
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif
" Trying changing map to open nerdtree

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:NERDTreeWinSize=50
"let NERDTreeShowHidden=1
let g:NERDTreeWinPos = "right"

" Close nerdtree after opening a file using o, i, t, T
" :help nerdtreequitonopen
" Value  | NERDTree Window Behavior
" -------+-------------------------------------------------------
" 0      | No change
" 1      | Closes after opening a file
" 2      | Closes the bookmark table after opening a bookmark
" 3(1+2) | Same as both 1 and 2
let NERDTreeQuitOnOpen='1'
nmap <leader><leader>ntl :let g:NERDTreeWinPos = "left"<CR>
nmap <leader><leader>ntr :let g:NERDTreeWinPos = "right"<CR>

" NERDTree vim-devicons
set guifont=HackNFM:h11


" set default clipboard to system
set clipboard=unnamed
let g:turbux_command_rspec  = 'zeus rspec'
map <leader>rz :let g:turbux_command_rspec = 'zeus rspec'<cr>
map <leader>rnz :let g:turbux_command_rspec = 'rspec'<cr>

" Runs all specs (no matter what) in chum docker env
"map <leader>rdz :let g:turbux_command_rspec = 'docker exec -it lms_app_1 bash -c "unset RAILS_ENV; zeus rspec $@"'<cr>

" when using a dev bulid of zeus
map <leader>rlz :let g:turbux_command_rspec = '~/.go/src/github.com/burke/zeus/build/zeus rspec'<cr>

inoremap <C-s> <Esc>:w<CR>
nnoremap <C-s> :w<CR>
map <leader>R :w<cr>:VimuxPromptCommand<cr>
map <leader>r :w<cr>:VimuxRunLastCommand<cr>
"imap <leader>R <esc>:w<cr>:VimuxPromptCommand<cr>
"imap <leader>r <esc>:w<cr>:VimuxRunLastCommand<cr>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" VimGutter -- trade accuracy for speed
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" rails.vim projections
let g:rails_projections = {
      \ "config/projections.json": {
      \   "command": "projections"
      \ },
      \ "spec/javascripts/unit/*_spec.js.coffee": {
      \   "command": "jspec",
      \   "alternate": "app/assets/javascripts/%s.js.coffee",
      \   "template": "describe \"%S\", ->",
      \ },
      \ "app/assets/javascripts/%s.js.coffee": {
      \   "command": "coffee",
      \   "alternate": "spec/javascripts/unit/*_spec.js.coffee",
      \ },
      \ "spec/features/*_spec.rb": {
      \   "command": "feature",
      \   "template": "require 'spec_helper'\n\nfeature '%h' do\n\nend",
      \ }}

" Detect ngt as html filetype
autocmd BufRead,BufNewFile *.ngt setlocal filetype=html

" Don't wait so long for key sequences
set timeoutlen=300

" Vim can get really slow when it has to syntax highlight long lines
" Limiting the syntax highlight length speeds things up
set synmaxcol=200

" Use the silver searcher as replacement for Ack
let g:ackprg = 'ag --nogroup --nocolor --column'
" quick start to search in app directory
" TODO make this open new tab first
nnoremap <Leader>a :Ack!<Space>-i<Space>''<Space>.<Left><Left><Left>
au FileType javascript nnoremap <Leader>a :Ack!<Space>-i<Space>''<Space>src<Left><Left><Left><Left><Left>
au FileType javascriptreact nnoremap <Leader>a :Ack!<Space>-i<Space>''<Space>src<Left><Left><Left><Left><Left>
au FileType json nnoremap <Leader>a :Ack!<Space>-i<Space>''<Space>src<Left><Left><Left><Left><Left>
au FileType ruby nnoremap <Leader>a :Ack!<Space>-i<Space>''<Space>app<Left><Left><Left><Left><Left>
au FileType eruby nnoremap <Leader>a :Ack!<Space>-i<Space>''<Space>app<Left><Left><Left><Left><Left>

" Emmet settings
let g:user_emmet_settings = {
\  'indentation' : '  ',
\}
let g:emmet_html5 = 1
let g:user_emmet_leader_key='<C-F1>'

set runtimepath^=~/.vim/bundle/ctrlp.vim
" Make ctrlp indexing faster
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ --ignore "tmp/*"
      \ --ignore "log/*"
      \ --ignore "node_modules"
      \ -g ""'

" Make ctrlp search faster
" ctrlp-cmatcher setup
"let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
" ctrlp-py-matcher setup
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Make ctrlp work with nested git reops
let g:ctrlp_working_path_mode = 0

" Set delay to prevent extra search
let g:ctrlp_lazy_update = 120

" Do not clear filenames cache, to improve CtrlP startup
" You can manualy clear it by <F5>
let g:ctrlp_clear_cache_on_exit = 0

" Set no file limit, we are building a big project
let g:ctrlp_max_files = 0

" If ag is available use it as filename list generator instead of 'find'
if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
endif

" Toggle text wrapping
map <leader>sw :set wrap!<CR>

" Clear whitespace from entire file
map <leader>ws :%s/\s\+$//<CR>

" Clear trailing whitespace and replace preceding tabs with double spaces
map <leader>ts :%s/	/  /g<CR>:%s/\s\+$//<CR>

" -------- Code Folding --------
" Make line folding persistent by saving with :mkview and retreiving with :loadview
" Line folding can be accomplished with v{movement}zf
"map <leader>mv :mkview<CR>
"map <leader>lv :loadview<CR>

" execute when cursor is over a fold {{{ to close the fold
"map <leader>fcl :foldclose<CR>
" -------- end Code Folding --------

" --------- typescript compiling ----------
"let g:typescript_compiler_binary = 'tsc'
"let g:typescript_compiler_options = ''
"autocmd QuickFixCmdPost [^l]* nested cwindow
"autocmd QuickFixCmdPost    l* nested lwindow
" then, run :make while editing a TypeScript file to execute the tsc compiler and display errors in the QuickFix window
" source: http://www.blog.bdauria.com/?p=692

" --------- Prettier ---------

" Format with prettier on command
nmap <Leader>p :Prettier<CR>

" Autoformat on save
let g:prettier#autoformat = 0
au FileType javascript let g:prettier#autoformat = 1
au FileType javascriptreact let g:prettier#autoformat = 1
au FileType json let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
nnoremap <leader>pn :let g:prettier#autoformat = 0<CR>
nnoremap <leader>py :let g:prettier#autoformat = 1<CR>

" --------- end Prettier ---------

" screeps dev
map <leader>pushscreeps :! push_screeps_code<CR>
"set shellcmdflag=-ic  " makes ctrl-p not work when set after vim is open, and
"  opens in background when set in vimrc


nnoremap <Leader>r1 :res10<CR>
nnoremap <Leader>r2 :res20<CR>
nnoremap <Leader>r3 :res30<CR>
nnoremap <Leader>r4 :res40<CR>
nnoremap <Leader>r5 :res50<CR>
nnoremap <Leader>r6 :res60<CR>
nnoremap <Leader>r7 :res70<CR>
nnoremap <Leader>r8 :res80<CR>
nnoremap <Leader>r9 :res90<CR>


" Highlight similar words
nnoremap <Leader>m :exec 'match StatusLineTerm /' . expand('<cword>') . '/'<CR>
nnoremap <Leader>M :exec 'match '<CR>

" Auto highlight markers and others (can only use 9 matches though)
" source https://stackoverflow.com/questions/36868879/does-vim-have-a-character-limit-for-regexes
"match Todo /\(FIXME\)\|\(TODO\)\|\(STARTHERE\)\|\(NOTE\)\|\(OPTIMIZE\)\|\(IDEA\)\|\(WIP\)\|\(TMP\)\|\(NOTRENDERED\)\|\(console.log\)\|\(console.debug\)\|\(debugger\)\|\(print\)\|\(pp\)\|\(byebug\)/
au BufReadPost,BufNewFile * match Todo /\(FIXME\)\|\(TODO\)\|\(STARTHERE\)\|\(NOTE\)\|\(OPTIMIZE\)\|\(byebug\)\|\(console\.log\)\|\(DEBUG\)\|\(print\)/


" Run current file
" This one isn't working for some reason
"map <leader>w :w | ! %:p
nnoremap <leader>w :w<CR>:! %:p<CR>
"nmap <F13>:!python %:p
"imap <F13> <Esc>:w<CR>:!python %:p
"nmap <C-v><F2>:terminal


" -- NOTES --
"  to format json
"  :%!python -m json.tool
"

" Highlight things just like TODO is highlighted
"syn match cTodo contained "\<console.log"
"hi default link consLogs Todo

" Finally got this working by copying the <leader>m stuff above
" More highlight colors https://jordanelver.co.uk/blog/2015/05/27/working-with-vim-colorschemes/
"match Todo /\(FIXME\)\|\(TODO\)\|\(STARTHERE\)\|\(console.log\)\|\(NOTE\)/
"syn match Todo /\(FIXME\)\|\(TODO\)\|\(STARTHERE\)\|\(console.log\)\|\(NOTE\)/
"nnoremap <leader>tm :exec 'match Todo /\(FIXME\)\|\(TODO\)\|\(STARTHERE\)\|\(console.log\)\|\(NOTE\)/'<CR>
"
"syn match myTodo contained "\<\(IDEA\)"
"hi def link myTodo Todo
"
"syn keyword myTodo      TODO FIXME XXX TBD NOTE STARTHERE console.log contained
"syn match myTodo "\/\/.*" contains=@Spell,myTodo
"hi def link myTodo		Todo

"autocmd Syntax * syntax keyword allTodo STARTHERE

"augroup vimrc_todo
    "au!
    "au Syntax * syn keyword myTodo      TODO FIXME XXX TBD NOTE STARTHERE console.log contained
    "au Syntax * syn match myTodo "\/\/.*" contains=@Spell,myTodo
    "hi def link myTodo		Todo
    ""au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX):/
          ""\ containedin=.*Comment,vimCommentTitle
"augroup END
"hi def link MyTodo Todo

"au Syntax * syn keyword myTodo      TODO FIXME XXX TBD NOTE STARTHERE console.log contained
"au Syntax * syn match myTodo "\/\/.*" contains=@Spell,myTodo
"au Highlight * hi def link myTodo		Todo

"au! syntax * source $VIM/syntax/custom.vim

" ----- Swap Panes -----
function! MarkWindowSwap()
  let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
  " Mark desination
  let curNum = winnr()
  let curBuf = bufnr("%")
  exe g:markedWinNum . "wincmd w"

  " Switch to source and shuffle dest->src
  let markedBuf = bufnr("%")

  " Hide and open so that we aren't propted and keep history
  exe 'hide buf' curBuf

  " Switch to dest and shuffle src->dest
  exe curNum . "wincmd w"

  " Hide and open so that we aren't propted and keep history
  exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>sm :call MarkWindowSwap()<CR>
nmap <silent> <leader>sd :call DoWindowSwap()<CR>

" vvv A better swapping strategy vvv
function! MarkWindowSwap2()
    " marked window number
    let g:markedWinNum = winnr()
    let g:markedBufNum = bufnr("%")
endfunction

function! DoWindowSwap2()
    let curWinNum = winnr()
    let curBufNum = bufnr("%")
    " Switch focus to marked window
    exe g:markedWinNum . "wincmd w"

    " Load current buffer on marked window
    exe 'hide buf' curBufNum

    " Switch focus to current window
    exe curWinNum . "wincmd w"

    " Load marked buffer on current window
    exe 'hide buf' g:markedBufNum
endfunction

nnoremap <leader>H :call MarkWindowSwap2()<CR> <C-w>h :call DoWindowSwap2()<CR>
nnoremap <leader>J :call MarkWindowSwap2()<CR> <C-w>j :call DoWindowSwap2()<CR>
nnoremap <leader>K :call MarkWindowSwap2()<CR> <C-w>k :call DoWindowSwap2()<CR>
nnoremap <leader>L :call MarkWindowSwap2()<CR> <C-w>l :call DoWindowSwap2()<CR>
" ----- end Swap Panes -----

" ----- Scrolling vertically and horizontaly -----
"nnoremap <ScrollWheelUp> j
"nnoremap <ScrollWheelDown> k
"nnoremap <ScrollWheelDown> k

nnoremap <silent> zh :call HorizontalScrollMode('h')<CR>
nnoremap <silent> zl :call HorizontalScrollMode('l')<CR>
nnoremap <silent> zH :call HorizontalScrollMode('H')<CR>
nnoremap <silent> zL :call HorizontalScrollMode('L')<CR>

function! HorizontalScrollMode(call_char)
  if &wrap
    return
  endif

  echohl Title
  let typed_char = a:call_char
  while index(['h', 'l', 'H', 'L'], typed_char) != -1
    execute 'normal! z'.typed_char
    redraws
    echon '-- Horizontal scrolling mode (h/l/H/L)'
    let typed_char = nr2char(getchar())
  endwhile
  echohl None | echo '' | redraws
endfunction

" ----- end Scrolling vertically and horizontaly -----
"
" --- Disable side scroll wheel
:nmap <ScrollWheelLeft> <nop>
:nmap <ScrollWheelRight> <nop>

" ===== Autoclosing brackets and things =====
" Inspired by https://vim.fandom.com/wiki/Automatically_append_closing_characters
" Curly Brackets {}
inoremap {              {}<Left>
inoremap <expr> }       strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

" Square Brackets []
inoremap [              []<Left>
inoremap <expr> ]       strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

" Parenthesis ()
inoremap (              ()<Left>
inoremap <expr> )       strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

" Less than Greater than <>
inoremap <              <><Left>
inoremap <expr> >       strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"

" A nicer way of moving closing characters to the next line
inoremap <expr> <CR>    strpart(getline('.'), col('.')-1, 1) == "}" ? "\<CR>\<Up>\<End>\<CR>" : strpart(getline('.'), col('.')-1, 1) == ")" ? "\<CR>\<Up>\<End>\<CR>" : strpart(getline('.'), col('.')-1, 1) == "]" ? "\<CR>\<Up>\<End>\<CR>" : strpart(getline('.'), col('.')-1, 1) == ">" && strpart(getline('.'), col('.')-2, 1) == "/" ? "\<Left>\<CR>\<Up>\<End>" : strpart(getline('.'), col('.')-1, 1) == ">" ? "\<CR>\<Up>\<End>" : "\<CR>"

" === Quotes ===
" Single Quotes
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"

" Double Quotes
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"

" Back tick
inoremap <expr> ` strpart(getline('.'), col('.')-1, 1) == "`" ? "\<Right>" : "\`\`\<Left>"

" Remove forward matching character if I change my mind
inoremap <expr> <BS>    strpart(getline('.'), col('.')-1, 1) == "'" && strpart(getline('.'), col('.')-2, 1) == "'" ? "\<BS>\<Del>" : strpart(getline('.'), col('.')-1, 1) == '"' && strpart(getline('.'), col('.')-2, 1) == '"' ? "\<BS>\<Del>" : strpart(getline('.'), col('.')-1, 1) == "`" && strpart(getline('.'), col('.')-2, 1) == "`" ? "\<BS>\<Del>" : strpart(getline('.'), col('.')-1, 1) == "}" && strpart(getline('.'), col('.')-2, 1) == "{" ? "\<BS>\<Del>" : strpart(getline('.'), col('.')-1, 1) == "]" && strpart(getline('.'), col('.')-2, 1) == "[" ? "\<BS>\<Del>" : strpart(getline('.'), col('.')-1, 1) == ")" && strpart(getline('.'), col('.')-2, 1) == "(" ? "\<BS>\<Del>" : strpart(getline('.'), col('.')-1, 1) == ">" && strpart(getline('.'), col('.')-2, 1) == "<" ? "\<BS>\<Del>" : "\<BS>"
inoremap <expr> <c-w>    strpart(getline('.'), col('.')-1, 1) == "'" && strpart(getline('.'), col('.')-2, 1) == "'" ? "\<c-w>\<Del>" : strpart(getline('.'), col('.')-1, 1) == '"' && strpart(getline('.'), col('.')-2, 1) == '"' ? "\<c-w>\<Del>" : strpart(getline('.'), col('.')-1, 1) == "`" && strpart(getline('.'), col('.')-2, 1) == "`" ? "\<c-w>\<Del>" : strpart(getline('.'), col('.')-1, 1) == "}" && strpart(getline('.'), col('.')-2, 1) == "{" ? "\<c-w>\<Del>" : strpart(getline('.'), col('.')-1, 1) == "]" && strpart(getline('.'), col('.')-2, 1) == "[" ? "\<c-w>\<Del>" : strpart(getline('.'), col('.')-1, 1) == ")" && strpart(getline('.'), col('.')-2, 1) == "(" ? "\<c-w>\<Del>" : strpart(getline('.'), col('.')-1, 1) == ">" && strpart(getline('.'), col('.')-2, 1) == "<" ? "\<c-w>\<Del>" : "\<c-w>"

au FileType javascript      inoremap :<space>    : ,<Left>
au FileType javascriptreact inoremap :<space>    : ,<Left>
au FileType json            inoremap :<space>    : ,<Left>
au FileType javascript      inoremap <expr> , strpart(getline('.'), col('.')-1, 1) == "\," ? "\<Right>" : "\,"
au FileType javascriptreact inoremap <expr> , strpart(getline('.'), col('.')-1, 1) == "\," ? "\<Right>" : "\,"
au FileType json            inoremap <expr> , strpart(getline('.'), col('.')-1, 1) == "\," ? "\<Right>" : "\,"


" ===== Vim-AI chatgpt
let s:initial_chat_prompt =<< trim END
>>> system

You are going to play a role of a completion engine with following parameters:
Task: Provide compact code/text completion, generation, transformation or explanation
Topic: general programming and text editing
Style: Plain result without any commentary
Audience: Users of text editor and programmers that need to transform/generate text
END

"let g:vim_ai_chat = {
"\   "engine": "chat",
"\   "options": {
"\     "temperature": 0.5,
"\     "max_tokens": 4000,
""\    "initial_prompt": s:initial_chat_prompt,
"\   },
"\ }

let g:vim_ai_complete = {
\  "engine": "complete",
\  "options": {
\    "model": "gpt-3.5-turbo-instruct",
\    "endpoint_url": "https://api.openai.com/v1/completions",
\    "max_tokens": 1000,
\    "temperature": 0.1,
\    "request_timeout": 20,
\    "enable_auth": 1,
\    "selection_boundary": "#####",
\  },
\  "ui": {
\    "paste_mode": 1,
\  },
\}

let g:vim_ai_edit = {
\   "engine": "chat",
\   "options": {
\     "model": "gpt-4",
\     "temperature": 0.5,
\     "max_tokens": 4000,
\   },
\ }

"let g:vim_ai_chat = {
"\   "options": {
"\     "model": "gpt-4",
"\     "temperature": 0.2,
"\   },
"\ }
" Default configs (4/12/23)
"let g:vim_ai_chat = {
"\   "engine": "complete",
"\   "options": {
"\     "model": "gpt-3.5-turbo",
"\     "max_tokens": 1000,
"\     "temperature": 0.1,
"\     "request_timeout": 20,
"\   },
"\ }

" AI Complete current line
nnoremap <leader>aic :AI<CR>
xnoremap <leader>aic :AI<CR>

" Chat
nnoremap <leader>ai :AIChat<CR>
xnoremap <leader>ai :AIChat<CR>

" Edit current line with instructions
nnoremap <leader>aie :AIEdit<CR>
xnoremap <leader>aie :AIEdit<CR>

nnoremap <leader>air :AIRedo<CR>

nnoremap <leader>aiw :w ~/code/_testtube/chatgpt/.aichat<Left><Left><Left><Left><Left><Left><Left>

" Save output of map to file https://stackoverflow.com/a/2240892
"   make sure to scroll to the bottom first
" :redir >> ~/mymaps.txt
" :map
" :redir END
