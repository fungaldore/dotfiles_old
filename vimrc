" to install plugins using pathogen
" source: https://gist.github.com/romainl/9970697
execute pathogen#infect()

" Load vim.plug bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

if filereadable(expand("~/.vimrc.common.vim"))
  source ~/.vimrc.common.vim
endif


""
"" Vim specific customizations
""

" Power Line Config
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

"" Make vim-illuminate work again
"set termguicolors

if has("mouse_sgr")
  set ttymouse=sgr
else
  set ttymouse=xterm2
end

""
"" Experiment
""
"" Integrate with Ale
"let g:ale_fix_on_save = 1
"let g:ale_fixers = { 'javascript': ['prettier', 'eslint'] }

"" ===== YouCompleteMe ====== "
"" Start autocompletion after 3 chars
"let g:ycm_min_num_of_chars_for_completion = 3
"let g:ycm_min_num_identifier_candidate_chars = 3
"let g:ycm_enable_diagnostic_highlighting = 0
"let g:ycm_semantic_triggers = { 'html,css,vim,javascript': ['re!.'] }
"set completeopt=popup,menuone

" ====== Vim Illuminate
"nnoremap <A-n> :require('illuminate').goto_next_reference(wrap)
"nnoremap <A-p> :require('illuminate').goto_prev_reference(wrap)
