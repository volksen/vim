"----------------------- plugins
source ~/.vim/packages.vim

filetype plugin indent on

"----------------- FZF
" Ctrl-u clears any command in command mode before calling FZF
nnoremap <C-p> :<C-u>FZF<CR>

"-------------------- grepper
let g:grepper = {}
let g:grepper.tools = ['rg', 'grep', 'git']
" Search for the current word
nnoremap <Leader>* :Grepper -cword -noprompt<CR>
" Search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

"set grepprg=rg\ -H\ --no-heading\ --vimgrep
"set grepformat=$f:$l:%c:%m
 
"----------------------- WSL copy test                                                                            
" WSL yank support                                                                                                
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " default location                                               
if executable(s:clip)                                                                                             
    augroup WSLYank                                                                                               
        autocmd!                                                                                                  
        autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)  
    augroup END                                                                                                   
end                                                                                                               

set nobackup      
set writebackup 
 
function! SetupCommandAlias(input, output)
	exec 'cabbrev <expr> '.a:input
		\ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
		\ .'? ("'.a:output.'") : ("'.a:input.'"))'
endfunction
call SetupCommandAlias("grep", "GrepperGrep")
call SetupCommandAlias("rg", "GrepperRg")

" Open Grepper-prompt for a particular grep-alike tool
"nnoremap <Leader>g :Grepper -tool rg<CR>
nnoremap <Leader>G :Grepper -tool git<CR>

"------------------------ vim specific settings
set nocompatible					" Vim Mode, no vi compatibility
set backspace=indent,eol,start		" backspace over everything in VIM
set history=1550		" keep more lines of command line history
set ruler				" show line, columns, percentages in status bar
set showcmd				" display incomplete commands in status bar

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo, so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

if has('mouse')
	set mouse=v  
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

" ==================================== My stuff
set virtualedit=all				" cursor virtuell over everything
set hidden						" allow hidden buffers
set wildmenu                    " menu tab completion
"set wildmode=longest,list,full  " how to do tab completion, like bash
set wildmode=full				" like fish
set nu                          " line numbers

try
  colorscheme  seoul256
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry

syntax on           " syntax highlighting
set nocursorline
set ignorecase      " search ignore case
set smartcase       " search respect case if Uppercase
set incsearch		" do incremental searching
set hlsearch        " highlight search cases

"--------------------- command history with c-p and c-n
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

"--------------------- clear hlsearch
" Use <C-L> to clear the highlighting of :set hlsearch. (Ctrl-L redraws screen)
if maparg('<C-l>', 'n') ==# ''
	nnoremap <silent> <C-l> :nohlsearch<CR><C-l>
endif

set diffopt+=vertical

noremap <F5> :diffupdate<CR>

"---------------- matchit plugin
packadd! matchit

"--------------- repeat q macro
nnoremap Q @q

"------------------- path for :find
set path=**

"------------ completion
"set completeopt=longest,menuone


"--------------------------- leader key
let mapleader=','
noremap \ ,

"----------------------- eng keyboard keys
if has('unix')
nmap Ã¼ <C-]>
nmap <leader>Ã¼ g<C-]>
nmap Ã¶ [
nmap Ã¤ ]
nmap Ã– {
nmap Ã„ }

omap Ã¼ <C-]>
omap <leader>Ã¼ g<C-]>
omap Ã¶ [
omap Ã¤ ]
omap Ã– {
omap Ã„ }

xmap Ã¼ <C-]>
xmap <leader>Ã¼ g<C-]>
xmap Ã¶ [
xmap Ã¤ ]
xmap Ã– {
xmap Ã„ }
elseif has('win32')
nmap ü <C-]>
nmap <leader>ü g<C-]>
nmap ö [
nmap ä ]
nmap Ö {
nmap Ä }

omap ü <C-]>         
omap <leader>ü g<C-]>
omap ö [             
omap ä ]             
omap Ö {             
omap Ä }             

xmap ü <C-]>         
xmap <leader>ü g<C-]>
xmap ö [             
xmap ä ]             
xmap Ö {             
xmap Ä }             
endif


"----------- text bubbling 2: only works with unimpaired plugin
"Bubble single lines
nmap <A-Up> [e
nmap <A-Down> ]e
" Bubble multiple lines
vmap <A-Up> [egv
vmap <A-Down> ]egv

"------------------ linewise up down but keep cursor
nmap <C-Up> <C-y>
nmap <C-Down> <C-e>

"-------------------------- select text again when copy paste
" Visually select the text that was last edited/pasted
nmap gV `[v`]

"------------------------------- gundo
"nnoremap <leader>u :GundoToggle<CR>

"------------------------------ vimrc
nmap <leader>v :tabedit $MYVIMRC<CR>
" Source the vimrc file after saving it

augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" ------------------------------------------- tabstops and indent
set ts=4 sts=4 sw=4 noexpandtab
set cino=N-s   "do not indent namespace when auto indent

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
	let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
	if l:tabstop > 0
		let &l:sts = l:tabstop
		let &l:ts = l:tabstop
		let &l:sw = l:tabstop
	endif
	call SummarizeTabs()
endfunction

function! SummarizeTabs()
	try
		echohl ModeMsg
		echon 'tabstop='.&l:ts
		echon ' shiftwidth='.&l:sw
		echon ' softtabstop='.&l:sts
		if &l:et
			echon ' expandtab'
		else
			echon ' noexpandtab'
		endif
	finally
		echohl None
	endtry
endfunction

"--------------------- substitue (repeat sub with same parameters)
nnoremap & :&&<CR>
xnoremap & :&&<CR>

"----------------------------------- wrapping and linebreaks
command! -nargs=* Wrap set wrap linebreak nolist

"----------------------------------- remove white spaces and indent file
function! Preserve(command)
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business:
	execute a:command
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction
" removes trailing whitespace in buffer
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
" indents whole buffer
nmap _= :call Preserve("normal gg=G")<CR>

"------------------------------- ident with ctrl+cursor keys
nmap <C-Left> <<
nmap <C-Right> >>
vmap <C-Left> <gv
vmap <C-Right> >gv

"----------------------------------------------------- gui
if has("gui_running")
	" Maximize gvim window
	set lines=999 columns=999
	set guioptions -=T    " no toolbar
endif

"-------------------------------------- spell checking
set spelllang=de_de

"--------------------------------------- window movement
" this allows to navigate between windows using CTRL-hjkl
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"------------------------------ wrapped lines (display lines)
vnoremap <Down> gj
vnoremap <Up> gk
nnoremap <Down> gj
nnoremap <Up> gk
"vmap <C-4> g$
"vmap <C-6> g^
"vmap <C-0> g^
"nmap <C-4> g$
"nmap <C-6> g^
"nmap <C-0> g^

"-------------------------------------------------- tabs
" for linux and windows users (using the control key)
map <C-S-]> gt
map <C-S-[> gT
map <C-1> 1gt
map <C-2> 2gt
map <C-3> 3gt
map <C-4> 4gt
map <C-5> 5gt
map <C-6> 6gt
map <C-7> 7gt
map <C-8> 8gt
map <C-9> 9gt
map <C-0> :tablast<CR>

"------------------------------- clipboard interaction
"if has('unnamedplus')
"	set clipboard=unnamed,unnamedplus
"endif

" NERDTree File explorere
map <F2> :NERDTreeToggle<CR>
map <F3> :NERDTreeFind<CR>
"let NERDTreeHijackNetrw=0

"-------------------- path to current file
map <leader>. :lcd %:p:h<CR>

"------------------------------------- open in current dir
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

""----------------------------------- LATEX
"set grepprg=grep\ -nH\ $*
"let g:tex_flavor='latex'
"set iskeyword+=:
"
""au BufEnter *.tex set autowrite
"let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_MultipleCompileFormats = 'pdf'
"let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
"let g:Tex_GotoError = 0
"let g:Tex_ViewRule_pdf = 'evince'
"let g:Tex_SmartQuoteOpen = '"`'
"let g:Tex_SmartQuoteClose = "\"'"
""let g:Tex_AutoFolding = 0
""let g:Tex_Folding=0

"-------------------- disable arrow keys for training
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

""--- minpac package manager --> commented now in packages.vim
"packadd minpac
"call minpac#init()
"command! PackUpdate call minpac#update()
"command! PackClean call minpac#clean()
""------------------- plugins
"call minpac#add('k-takata/minpac', {'type': 'opt'})
"call minpac#add('tpope/vim-unimpaired')

"Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"---- jump to last edit location when opening a file
"if has("autocmd")
"	filetype plugin indent on
"	augroup vimrcEx
"		au!
"		autocmd FileType text setlocal textwidth=78
"		" When editing a file, always jump to the last known cursor position.
"		autocmd BufReadPost *
"					\ if line("'\"") > 1 && line("'\"") <= line("$") |
"					\   exe "normal! g`\"" |
"					\ endif
"	augroup END
"else
"	set autoindent		" autoindenting on (keeps indent across lines when pressing enter)
"endif " has("autocmd")

let g:markdown_fenced_languages = ['python','css', 'erb=eruby', 'javascript', 'bash=sh', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml']

