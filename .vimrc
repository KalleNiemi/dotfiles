vim9script

#Plugins:
call plug#begin()
Plug 'rust-lang/rust.vim'
Plug 'liuchengxu/vista.vim'
#Plug 'preservim/tagbar'
#Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'yegappan/lsp'
Plug 'preservim/nerdtree'
Plug 'scrooloose/nerdcommenter'
#color themes:
Plug 'scheakur/vim-scheakur'
Plug 'NLKNguyen/papercolor-theme'
#Plug 'marcopaganini/termschool-vim-theme'
#Plug 'ayu-theme/ayu-vim'
call plug#end()
filetype plugin indent on
filetype plugin on
#set termguicolors     " enable true colors support
#var ayucolor="light"  " for light version of theme
#var ayucolor="mirage" " for mirage version of theme
#var ayucolor="dark"   " for dark version of theme
#colorscheme ayu
colorscheme PaperColor
#colorscheme termschool
#colorscheme scheakur

# Run PlugInstall if there are missing plugins
autocmd VimEnter * {
	if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
		PlugInstall --sync | source $MYVIMRC
	endif
	}
#vim settings
set viminfo='100,f1
set number
set relativenumber
set background=dark
set laststatus=2
syntax on
highlight LineNrBelow ctermfg=4
highlight LineNrAbove ctermfg=4
highlight LineNr ctermfg=7
#highlight CursorLineNr ctermfg=6

### Function to remove trailing white spaces
### and command to call it
def g:RemoveWhitespaces(): void
	:%s/\s\+$\| \+\ze\t/
	:noh
enddef

command RMWS :call RemoveWhitespaces()

command FIX :LspCodeAction
command GDEC :LspGotoDeclaration
### Keybinds ###

#Remove highlight from selectrion
nnoremap <silent> <Esc><Esc> :noh<CR>

# LSP specific
nmap <silent> <F4> :Vista!!<CR>
nmap <silent> <F5> :execute "normal \<C-O>"<CR>

nmap <silent> <F6> :LspGotoDefinition<CR>
nmap <silent> <F7> :LspDiagShow<CR>
nmap <silent> <F8> :LspDiagHere<CR>
#Fugitive
nmap <silent> <F9> :Git blame<CR>
#Toggle NERDTree
nmap <silent> <F2> :NERDTreeToggle<CR>

#Show trailing white space
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWinLeave * call clearmatches()
autocmd WinNew * match ExtraWhitespace /\s\+$\| \+\ze\t/
#Autoread begin
set autoread
au CursorHold * checktime
call feedkeys("lh")
#Autoread end

##LSP setup

var lspOpts = {
  aleSupport: false,
  autoComplete: false,
  autoHighlight: false,
  autoHighlightDiags: true,
  autoPopulateDiags: false,
  completionMatcher: 'case',
  completionMatcherValue: 1,
  diagSignErrorText: 'E>',
  diagSignHintText: 'H>',
  diagSignInfoText: 'I>',
  diagSignWarningText: 'W>',
  echoSignature: false,
  hideDisabledCodeActions: false,
  highlightDiagInline: true,
  hoverInPreview: false,
  ignoreMissingServer: false,
  keepFocusInDiags: true,
  keepFocusInReferences: true,
  completionTextEdit: false,
  diagVirtualTextAlign: 'after',
  diagVirtualTextWrap: 'default',
  noNewlineInCompletion: false,
  omniComplete: true,
  outlineOnRight: false,
  outlineWinSize: 30,
  semanticHighlight: false,
  showDiagInBalloon: false,
  showDiagInPopup: false,
  showDiagOnStatusLine: false,
  showDiagWithSign: true,
  showDiagWithVirtualText: false,
  showInlayHints: false,
  showSignature: true,
  snippetSupport: false,
  ultisnipsSupport: false,
  useBufferCompletion: false,
  usePopupInCodeAction: true,
  useQuickfixForLocations: false,
  vsnipSupport: false,
  bufferCompletionTimeout: 100,
  customCompletionKinds: false,
  completionKinds: {},
  filterCompletionDuplicates: false,
}


var lspServers = [
	# Clangd language server
	{
		name: 'clang',
		filetype: ['c', 'cpp'],
		path: 'clangd',
		args: ['--background-index'],
	},

#	# Rust language server
#	{
#		name: 'rustlang',
#		filetype: ['rust', 'rs'],
#		path: '/home/kale/.cargo/bin/rust-analyzer',
#		args: [],
#		syncInit: true,
#	},

  #Python language server
	{
		name: 'python',
		filetype: ['python'],
		path: 'pylsp',
	}

# Go language server
  # {
  #   name: 'golang',
  #   filetype: ['go', 'gomod'],
  #   path: 'gopls',
  #   args: ['serve'],
  #   syncInit: true,
  #   initializationOptions: {
  #   semanticTokens: true,
  #   },
  # },

  # Javascript/Typescript language server
  # {
  #   name: 'typescriptlang',
  #   filetype: ['javascript', 'typescript'],
  #   path: 'typescript-language-server',
  #   args: ['--stdio'],
  # },
]

augroup Lsp
  au!
  autocmd User LspSetup call LspOptionsSet(lspOpts)
  autocmd User LspSetup call LspAddServer(lspServers)
  autocmd User LspAttached {
    setlocal signcolumn=yes

    setlocal keywordprg=:LspHover
    setlocal tagfunc=lsp#lsp#TagFunc
    setlocal formatexpr=lsp#lsp#FormatExpr()
    nnoremap <buffer> <LocalLeader>f <Cmd>LspFormat<CR>
    nnoremap <buffer> <LocalLeader>a <Cmd>LspCodeAction<CR>
    nnoremap <buffer> <LocalLeader>r <Cmd>LspRename<CR>
    nnoremap <buffer> <LocalLeader>d <Cmd>LspDiag first<CR>
    nnoremap <buffer> [d <Cmd>LspDiag next<CR>
    nnoremap <buffer> ]d <Cmd>LspDiag prev<CR>
  }
augroup END
