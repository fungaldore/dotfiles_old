call plug#begin('~/.vim/plugged')

Plug 'ap/vim-css-color'
Plug 'ycm-core/YouCompleteMe'
Plug 'MunifTanjim/nui.nvim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-pathogen'
Plug 'tpope/vim-rails'
Plug 'benmills/vimux'
Plug 'jgdavey/vim-turbux'
"Plug 'powerline/powerline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'preservim/nerdcommenter'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-unimpaired'
Plug 'kchmck/vim-coffee-script'
Plug 'Lokaltog/vim-easymotion'
Plug 'mattn/livestyle-vim'
Plug 'mattn/emmet-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-endwise'
Plug 'rizzatti/funcoo.vim'
Plug 'rizzatti/dash.vim'
Plug 'tpope/vim-dispatch'
Plug 'digitaltoad/vim-jade'
Plug 'tpope/vim-projectionist'
Plug 'honza/vim-snippets'
Plug 'sjl/vitality.vim'
Plug 'keith/tmux.vim'
Plug 'fungaldore/fogbell.vim'
Plug 'prettier/vim-prettier'
Plug 'darfink/vim-plist'
Plug 'rrethy/vim-illuminate'
Plug 'sheerun/vim-polyglot'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'ryanoasis/vim-devicons' " Icons showing as chinese characters

call plug#end()


""
"" Import common configs
""
" Load vim.plug bundles
"if filereadable(expand("~/.vimrc.bundles"))
"  source ~/.vimrc.bundles
"endif

if filereadable(expand("~/.vimrc.common.vim"))
  source ~/.vimrc.common.vim
endif


""
"" Neovim specific configurations
""

""
"" Power Line Config (airline)
""
" Use powerline fonts for arrow separators
let g:airline_powerline_fonts = 1


" Lead Multispace
lua << EOF
vim.opt.listchars = { tab = "⇥ ", leadmultispace = "┊ ", trail = "␣", nbsp = "⍽" }
  function _G.AdjustListchars()
    local lead = "┊"
    for _ = 1, vim.bo.shiftwidth - 1 do
      lead = lead .. " "
    end
    vim.opt_local.listchars:append({ leadmultispace = lead })
  end
EOF
