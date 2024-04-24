"Automatc installing of vim plug plugin manager
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Ale settings
let g:ale_lint_on_text_changed = 'always'
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
"Plugins:
call plug#begin()
Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'
Plug 'dense-analysis/ale'
"color themes:
Plug 'scheakur/vim-scheakur'
Plug 'NLKNguyen/papercolor-theme'
"Plug 'marcopaganini/termschool-vim-theme'
"Plug 'ayu-theme/ayu-vim'
call plug#end()

"set termguicolors     " enable true colors support
"let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
"colorscheme ayu
colorscheme PaperColor
"colorscheme termschool
"colorscheme scheakur
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

"vim settings
set number
set relativenumber
set background=dark
set laststatus=2
syntax on
"highlight LineNr ctermfg=7
"highlight CursorLineNr ctermfg=6
"Keybinds
nnoremap <silent> <Esc><Esc> :noh<CR> :call clearmatches()<CR>
nmap <F8> :TagbarToggle<CR>

"Autoread begin    
set autoread    
au CursorHold * checktime    
call feedkeys("lh")    
"Autoread end

