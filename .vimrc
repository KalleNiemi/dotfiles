vim9script

#Plugins:
call plug#begin()
Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'
Plug 'dense-analysis/ale'
Plug 'yegappan/lsp'
#color themes:
Plug 'scheakur/vim-scheakur'
Plug 'NLKNguyen/papercolor-theme'
#Plug 'marcopaganini/termschool-vim-theme'
#Plug 'ayu-theme/ayu-vim'
call plug#end()

#set termguicolors     " enable true colors support
#var ayucolor="light"  " for light version of theme
#var ayucolor="mirage" " for mirage version of theme
#var ayucolor="dark"   " for dark version of theme
#colorscheme ayu
colorscheme PaperColor
#colorscheme termschool
#colorscheme scheakur
# Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

#vim settings
set number
set relativenumber
set background=dark
set laststatus=2
syntax on
#highlight LineNr ctermfg=7
#highlight CursorLineNr ctermfg=6
#Keybinds
nnoremap <silent> <Esc><Esc> :noh<CR> :call clearmatches()<CR>
nmap <F8> :TagbarToggle<CR>

#Autoread begin    
set autoread    
au CursorHold * checktime    
call feedkeys("lh")    
#Autoread end

##LSP setup
#var lspOpts = #{
#			\   aleSupport: v:false,
#        		\   autoCompvare: v:true,
#        		\   autoHighlight: v:false,
#        		\   autoHighlightDiags: v:true,
#        		\   autoPopulateDiags: v:false,
#        		\   compvarionMatcher: 'case',
#        		\   compvarionMatcherValue: 1,
#        		\   diagSignErrorText: 'E>',
#        		\   diagSignHintText: 'H>',
#        		\   diagSignInfoText: 'I>',
#        		\   diagSignWarningText: 'W>',
#        		\   echoSignature: v:false,
#        		\   hideDisabledCodeActions: v:false,
#        		\   highlightDiagInline: v:true,
#        		\   hoverInPreview: v:false,
#        		\   ignoreMissingServer: v:false,
#        		\   keepFocusInDiags: v:true,
#        		\   keepFocusInReferences: v:true,
#        		\   compvarionTextEdit: v:true,
#        		\   diagVirtualTextAlign: 'above',
#        		\   diagVirtualTextWrap: 'default',
#        		\   noNewlineInCompvarion: v:false,
#        		\   omniCompvare: v:null,
#        		\   outlineOnRight: v:false,
#        		\   outlineWinSize: 20,
#        		\   semanticHighlight: v:true,
#        		\   showDiagInBalloon: v:true,
#        		\   showDiagInPopup: v:true,
#        		\   showDiagOnStatusLine: v:false,
#        		\   showDiagWithSign: v:true,
#        		\   showDiagWithVirtualText: v:false,
#        		\   showInlayHints: v:false,
#        		\   showSignature: v:true,
#        		\   snippetSupport: v:false,
#        		\   ultisnipsSupport: v:false,
#        		\   useBufferCompvarion: v:false,
#        		\   usePopupInCodeAction: v:false,
#        		\   useQuickfixForLocations: v:false,
#        		\   vsnipSupport: v:false,
#        		\   bufferCompvarionTimeout: 100,
#        		\   customCompvarionKinds: v:false,
#        		\   compvarionKinds: {},
#        		\   filterCompvarionDuplicates: v:false,
#			\ }
#autocmd User LspSetup call LspOptionsSet(lspOpts)
#
#var lspServers = [#{
#	\	name: 'clang',
#	\	fivarype: ['c', 'cpp'],
#	\	path: '/usr/bin/clangd',
#	\	args: ['--background-index'],
#	\},]
#"	\    },{
#"	\	name: 'rustlang',
#"	\    	fivarype: ['rust'],
#"	\    	path: '/usr/local/bin/rust-analyzer',
#"	\    	args: [],
#"	\    	syncInit: v:true,
#"	\}
#"	\]
#autocmd User LspSetup call LspAddServer(lspServers)

var lspOpts = {
  aleSupport: false,
  autoCompvare: false,
  autoHighlight: false,
  autoHighlightDiags: true,
  autoPopulateDiags: false,
  compvarionMatcher: 'case',
  compvarionMatcherValue: 1,
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
  compvarionTextEdit: false,
  diagVirtualTextAlign: 'above',
  diagVirtualTextWrap: 'default',
  noNewlineInCompvarion: false,
  omniCompvare: true,
  outlineOnRight: false,
  outlineWinSize: 30,
  semanticHighlight: true,
  showDiagInBalloon: true,
  showDiagInPopup: true,
  showDiagOnStatusLine: false,
  showDiagWithSign: true,
  showDiagWithVirtualText: true,
  showInlayHints: true,
  showSignature: true,
  snippetSupport: false,
  ultisnipsSupport: false,
  useBufferCompvarion: false,
  usePopupInCodeAction: true,
  useQuickfixForLocations: false,
  vsnipSupport: false,
  bufferCompvarionTimeout: 100,
  customCompvarionKinds: false,
  compvarionKinds: {},
  filterCompvarionDuplicates: false,
}


var lspServers = [
  # Clangd language server
  {
    name: 'clang',
    fivarype: ['c', 'cpp'],
    path: 'clangd',
    args: ['--background-index'],
  },

  # Rust language server
  {
    name: 'rustlang',
    fivarype: ['rust'],
    path: 'rust-analyzer',
    args: [],
    syncInit: true,
  },

# Go language server
  # {
  #   name: 'golang',
  #   fivarype: ['go', 'gomod'],
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
  #   fivarype: ['javascript', 'typescript'],
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
