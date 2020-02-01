command! PackUpdate packadd minpac | source $MYVIMRC | redraw | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

if !exists('*minpac#init')
  finish
endif

call minpac#init()

"------------------- plugins
call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-obsession')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-abolish') 
call minpac#add('tpope/vim-commentary') 
call minpac#add('tpope/vim-repeat') 
call minpac#add('nelstrom/vim-visual-star-search')
call minpac#add('mhinz/vim-grepper')
call minpac#add('godlygeek/tabular')
call minpac#add('preservim/nerdtree') 
call minpac#add('junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} )
call minpac#add('junegunn/fzf.vim')
call minpac#add('dracula/vim', {'name':'dracula'})
call minpac#add('junegunn/seoul256.vim')
"call minpac#add('junegunn/vim-peekaboo')

