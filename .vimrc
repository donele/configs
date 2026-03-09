set nocompatible              " be iMproved, required
let mapleader =" "

" =========================
" Plugin Manager
"   $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   :PlugInstall
"   $ ~/.vim/plugged/fxf/install
"   $ suto apt install ripgrep
" =========================
filetype off                  " Pause filetype detection while plugins are being set up
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder core
Plug 'junegunn/fzf.vim' " Vim integration for fzf
call plug#end()
syntax on
filetype plugin indent on

" =========================
" General Settings
"   tabstop decide how to display tabs
"   shiftwidth control indentation behavior
" =========================
augroup MyPythonIndent
  autocmd!
  autocmd FileType python setlocal shiftwidth=4 softtabstop=-1 tabstop=4
augroup END

if exists('$VIM_CPP_INDENT')
  let g:cpp_indent = str2nr($VIM_CPP_INDENT)
else
  let g:cpp_indent = 4
endif

augroup MyCppIndent
  autocmd!
  autocmd FileType cpp execute 'setlocal shiftwidth='.g:cpp_indent
        \ . ' softtabstop='.g:cpp_indent
        \ . ' tabstop='.g:cpp_indent
augroup END

set expandtab " display spaces instead of '\t'
set hidden " allow unsaved buffers in background

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" =========================
" NERDTree Settings
" =========================
" autocmd VimEnter * if argc() == 0 | NERDTree | endif
" autocmd BufEnter * if winnr('$') == 1 && exists("b:NERDTree") | quit | endif
map <leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" =========================
" FZF Keybindings
" =========================
nnoremap <C-p> :Files<CR>
nnoremap <leader>D :Gvdiffsplit HEAD<CR>
nnoremap <leader>DD :Gvdiffsplit HEAD~<CR>
nnoremap <leader>D2 :Gvdiffsplit HEAD~2<CR>
nnoremap <leader>D3 :Gvdiffsplit HEAD~3<CR>
nnoremap <leader>D4 :Gvdiffsplit HEAD~4<CR>
nnoremap <leader>D5 :Gvdiffsplit HEAD~5<CR>
nnoremap <leader>D6 :Gvdiffsplit HEAD~6<CR>
nnoremap <leader>D7 :Gvdiffsplit HEAD~7<CR>
nnoremap <leader>D8 :Gvdiffsplit HEAD~8<CR>
nnoremap <leader>D9 :Gvdiffsplit HEAD~9<CR>
nnoremap <leader>g :GFiles?<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Rg<CR>

" Use ripgrep if available
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
endif

" =========================
" Fugitive Shortcuts
" =========================
set laststatus=2
set statusline=
set statusline+=%f            " file name
set statusline+=\ [%{&filetype}]
set statusline+=\ %h%m%r      " flags
set statusline+=\ %=          " right align
set statusline+=%{fugitive#statusline()}
set statusline+=\ %l:%c       " line:col
set statusline+=\ %p%%        " percentage
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gl :Git log<CR>

" Prefer vertical diffsplit
set diffopt=vertical

" Disable auto commenting.
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Tab definitions.
set tabstop=2 softtabstop=0 expandtab shiftwidth=2

" Extend % matching.
runtime macros/matchit.vim
" Path used for finding files.
set path+=~/gtdev/globaltickdata/source/include

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif

syntax on

"----------------------------------------------------------------------------
" Mappings ------------------------------------------------------------------
"----------------------------------------------------------------------------

" Colors
colo pablo
nnoremap <leader>1 :colo ron<cr>
nnoremap <leader>2 :colo pablo<cr>
nnoremap <leader>3 :colo default<cr>
nnoremap <leader>4 :colo delek<cr>
nnoremap <leader>5 :colo desert<cr>
nnoremap <leader>6 :colo elflord<cr>
nnoremap <leader>7 :colo slate<cr>

" Quick write.
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>p :set paste<cr>
nnoremap <leader>P :set nopaste<cr>
nnoremap <leader>h 2gt
nnoremap <leader>j gt
nnoremap <leader>k gT
nnoremap <leader>l 2gT
nnoremap <leader>= =a{
nnoremap <leader>s :source ~/.vimrc<cr>

" Dos format
nnoremap <leader>d :%s/$/\r/<cr>

" Disable F1
nmap <F1> <nop>
imap <F1> <nop>

" Let ; do what : does. Conflicts with current line search.
"nnoremap ; :

" Command history. Finger will come to 'k' already, so map it to 'k'.
" nnoremap <leader>k q:

" Let <leader>/ clear highlights.
set hlsearch
nmap <silent> <leader>/ :nohlsearch<cr>

" Insert lines.
nmap <leader>o o<ESC>k
nmap <leader>O O<ESC>j

" C-w
nmap <leader>w <C-w>

" Write as a root.
cmap w!! w !sudo tee % >/dev/null

"----------------------------------------------------------------------------
" tmux navigation -----------------------------------------------------------
"----------------------------------------------------------------------------
if exists('$TMUX')
	function! TmuxOrSplitSwitch(wincmd, tmuxdir)
		let previous_winnr = winnr()
		silent! execute "wincmd " . a:wincmd
		if previous_winnr == winnr()
            let iszoomed = system("tmux list-panes -F '#F' | grep Z | wc -w")
            if iszoomed == 0
			    call system("tmux select-pane -" . a:tmuxdir)
			    redraw!
            endif
		endif
	endfunction

	let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
	let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
	let &t_te = "\<Esc>]2;". previous_title ."\<Esc>\\" . &t_te

	nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
	nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
	nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
	nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l
endif
