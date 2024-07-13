lua require('plugins')
"vim settings
set number
set relativenumber
set background=dark
set laststatus=2
"syntax on

colorscheme torte

"key binds
nnoremap <silent> <Esc><Esc> :noh<CR> :call clearmatches()<CR>
nmap <F8> :TagbarToggle<CR>

"Autoread begin    
set autoread    
au CursorHold * checktime    
call feedkeys("lh")    
"Autoread end

