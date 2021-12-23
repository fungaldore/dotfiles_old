" to install plugins using pathogen
" source: https://gist.github.com/romainl/9970697
execute pathogen#infect()

"filetype plugin indent on
"syntax on


"""" Copied from Janus core settings

""
"" Basic Setup
""

set nocompatible      " Use vim, no vi defaults
set number            " Show line numbers
set ruler             " Show line and column number
syntax enable         " Turn on syntax highlighting allowing local overrides
set encoding=utf-8    " Set default encoding to UTF-8
set pastetoggle=<F3>

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

""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

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

" Power Line Config
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

" Load vim.plug bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif
syntax on
filetype plugin indent on

"""""""""""""" Colors """"""""""""""
" Setup Solarized
set background=dark
let g:solarized_visibility = 'high'
colorscheme solarized
call togglebg#map("<F5>")

" Fix ugly SignColumn particularly when using gitgutter
highlight clear SignColumn
autocmd ColorScheme * highlight clear SignColumn

nmap <leader>cfl :colorscheme fogbell_light<CR>
nmap <leader>cfd :colorscheme fogbell<CR>
nmap <leader>csd :colorscheme solarized<CR>


" Enable Mouse for when I'm feeling lazy
if has("mouse")
  set mouse=a
  " set mousehide
endif

set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs

if has("mouse_sgr")
  set ttymouse=sgr
else
  set ttymouse=xterm2
end

set noshowmode " Hide the default mode text, powerline already does

set colorcolumn=80,120

" Keep cursor from edge
set sidescroll=1
set sidescrolloff=5

"""" MAPPINGS

" Fugitive
nmap <leader>gs :Git<CR>

" Text Bubbling
" Bubble single lines
nmap <C-k> [e
nmap <C-j> ]e
" Bubble multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv

" NerdTree
map <leader>n :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<CR>
let g:NERDTreeWinSize=50
"let NERDTreeShowHidden=1

" Toggle hl search
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" set default clipboard to system
set clipboard=unnamed
let g:turbux_command_rspec  = 'zeus rspec'
map <leader>rz :let g:turbux_command_rspec = 'zeus rspec'<cr>
map <leader>rnz :let g:turbux_command_rspec = 'rspec'<cr>

" Runs all specs (no matter what) in chum docker env
"map <leader>rdz :let g:turbux_command_rspec = 'docker exec -it lms_app_1 bash -c "unset RAILS_ENV; zeus rspec $@"'<cr>

" when using a dev bulid of zeus
map <leader>rlz :let g:turbux_command_rspec = '~/.go/src/github.com/burke/zeus/build/zeus rspec'<cr>

map <leader>R :w<cr>:VimuxPromptCommand<cr>
map <leader>r :w<cr>:VimuxRunLastCommand<cr>
imap <leader>R <esc>:w<cr>:VimuxPromptCommand<cr>
imap <leader>r <esc>:w<cr>:VimuxRunLastCommand<cr>

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
" set timeout timeoutlen=150

" Vim can get really slow when it has to syntax highlight long lines
" Limiting the syntax highlight length speeds things up
set synmaxcol=200

" Use the silver searcher as replacement for Ack
let g:ackprg = 'ag --nogroup --nocolor --column'
" quick start to search in app directory
nnoremap <Leader>a :Ack!<Space>''<Space>app<Left><Left><Left><Left><Left>

let g:user_emmet_settings = {
\  'indentation' : '  ',
\}
let g:emmet_html5 = 1

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
"let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

" Make ctrlp work with nested git reops
let g:ctrlp_working_path_mode = 0

" ctrlp-py-matcher setup
"let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

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

" to blink highlight next search
nnoremap <silent>n n:call HLNext(0.03)<CR>
nnoremap <silent>N N:call HLNext(0.03)<CR>

function! HLNext (blinktime)
  set invcursorline
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  set invcursorline
  redraw
endfunction

" --------- typescript compiling ----------
"let g:typescript_compiler_binary = 'tsc'
"let g:typescript_compiler_options = ''
"autocmd QuickFixCmdPost [^l]* nested cwindow
"autocmd QuickFixCmdPost    l* nested lwindow
" then, run :make while editing a TypeScript file to execute the tsc compiler and display errors in the QuickFix window
" source: http://www.blog.bdauria.com/?p=692

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



" -- NOTES --
"  to format json
"  :%!python -m json.tool
"
