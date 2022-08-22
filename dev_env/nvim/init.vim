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

" Git related
call dein#add('airblade/vim-gitgutter')
call dein#add('tpope/vim-fugitive')

" Autocomplete related
call dein#add('hrsh7th/cmp-buffer')
call dein#add('hrsh7th/cmp-cmdline')
call dein#add('hrsh7th/cmp-nvim-lsp')
call dein#add('hrsh7th/cmp-path')
call dein#add('hrsh7th/nvim-cmp')
call dein#add('L3MON4D3/LuaSnip')
call dein#add('neovim/nvim-lspconfig')
call dein#add('saadparwaiz1/cmp_luasnip')

" Grep related
call dein#add('junegunn/fzf', { 'do': { -> fzf#install() } }) 
call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

" Formatting related
call dein#add('lukas-reineke/indent-blankline.nvim')
call dein#add('tpope/vim-surround')

" File explorer
call dein#add('kyazdani42/nvim-web-devicons')
call dein#add('kyazdani42/nvim-tree.lua')

" Syntax related
call dein#add('MaxMEllon/vim-jsx-pretty')
call dein#add('pangloss/vim-javascript')
call dein#add('plasticboy/vim-markdown')
call dein#add('typescript-language-server/typescript-language-server')

" Micellaneous
call dein#add('Pocco81/TrueZen.nvim')
call dein#add('vim-airline/vim-airline')
" call dein#add('vimwiki/vimwiki')

" Colorschemes
call dein#add('aditya-azad/candle-grey')
call dein#add('ajgrf/parchment')
call dein#add('Alvarocz/vim-northpole')
call dein#add('ayu-theme/ayu-vim')
call dein#add('bluz71/vim-moonfly-colors')
call dein#add('chriskempson/vim-tomorrow-theme')
call dein#add('daviddosomething/vim-colors-meh')
call dein#add('fenetikm/falcon')
call dein#add('fxn/vim-monochrome')
call dein#add('goatslacker/mango.vim')
call dein#add('huyvohcmc/atlas.vim')
call dein#add('kkga/vim-envy')
call dein#add('KKPMW/distilled-vim')
call dein#add('ldelossa/vimdark')
call dein#add('morhetz/gruvbox')
call dein#add('nanotech/jellybeans.vim')
call dein#add('noahfrederick/vim-hemisu')
call dein#add('pineapplegiant/spaceduck')
call dein#add('owickstrom/vim-colors-paramount')
call dein#add('robertmeta/nofrils')
call dein#add('reedes/vim-colors-pencil')
call dein#add('t184256/vim-boring')
call dein#add('zefei/cake16')

" Required:
call dein#end()

" If you want to install not installed plugins on startup.
"if dein#check_install()
" call dein#install()
"endif

" Required:
set encoding=utf-8
set t_Co=256
set termguicolors
set bg=dark
filetype plugin indent on
syntax enable
colorscheme boring

" Custom Mappings
imap jj <Esc>
let mapleader="'"

" Colorscheme tweak
" hi pythonFunction guifg=#d2a8ff
hi pythonFunction guifg=#b875ff
hi clear pythonComment

" Set absolute and relative line numbers
set nu rnu
" Convert tab to spaces
set expandtab
" Set tab to 2 spaces
set tabstop=2
" Set indent space to 2
set shiftwidth=2
" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" let g:netrw_liststyle=3
" let g:netrw_banner =0
" let g:netrw_browse_split=3
" let g:netrw_winsize=15
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

"Markdown
au BufRead,BufNewFile *.md setlocal textwidth=80

" Python/PHP tabwidth
autocmd FileType python,php setlocal shiftwidth=4 tabstop=4 expandtab

" vimwiki
" let g:vimwiki_global_ext = 0
" let g:vimwiki_list=[{ 'path' : '$HOME/app',
"   \ 'syntax' : 'markdown', 'ext' : '.md' }]

" Indent blank line
lua require('indent-blankline')

" LSP config
lua require('lsp-config')
lua require('lsp-cmp')

" Nvim tree
lua require('nvim-tree').setup()
nnoremap <C-n> :NvimTreeToggle

" netrw
" nnoremap <C-n> :Vexplore<CR>

" Check syntax group
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
