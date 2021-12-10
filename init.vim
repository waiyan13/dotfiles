if &compatible
  set nocompatible " Be iMproved
endif

" Required:
" Add the dein installation directory into runtimepath
set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim
set runtimepath+=~/.vim/bundles/repos/github.com/junegunn/fzf

" Required:
call dein#begin('~/.vim/bundles')

" Let dein manage dein
call dein#add('~/.vim/bundles')
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('airblade/vim-gitgutter')
call dein#add('danilo-augusto/vim-afterglow')
call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 }) 
call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
call dein#add('majutsushi/tagbar')
call dein#add('MaxMEllon/vim-jsx-pretty')
call dein#add('neovim/nvim-lspconfig')
call dein#add('pangloss/vim-javascript')
call dein#add('plasticboy/vim-markdown')
call dein#add('preservim/nerdtree')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-surround')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('vimwiki/vimwiki')

" Required:
call dein#end()

" Required:
set encoding=utf-8
filetype plugin indent on
syntax enable
colorscheme afterglow

" Custom Mappings
imap jj <Esc>
let mapleader="'"

" Remove comment hightlight
hi clear Comment
hi clear pythonInclude
hi clear pythonFunction

" Set absolute and relative line numbers
set nu rnu
" Convert tab to spaces
set expandtab
" Set tab to 2 spaces
set tabstop=2
" Set indent space to 2
set shiftwidth=2

" Vim airline
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
  let g:airline_symbols={}
endif

" If you want to install not installed plugins on startup.
"if dein#check_install()
" call dein#install()
"endif

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Nerdtree
map <silent> <C-k>b :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Vim tagbar
nmap <F8> :TagbarToggle<CR>

" Python/PHP tabwidth
autocmd FileType python,php setlocal shiftwidth=4 tabstop=4 expandtab

let g:python3_host_prog='/usr/local/bin/python3.8'

" LSP config
lua require('lsp-config')

" Vimwiki
let g:vimwiki_global_ext = 0
let g:vimwiki_list=[{ 'path' : '$HOME/app',
  \ 'syntax' : 'markdown', 'ext' : '.md' }]

" Check syntax group
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
