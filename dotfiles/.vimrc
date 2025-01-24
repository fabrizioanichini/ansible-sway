" ---------- Autoload VimPlug --------- " 
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ---------- Plugins -----------" 
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" ------ BASIC VIM SETTINGS --- " 
set number			" Show line numbers
set scrolloff=8			" Keep 8 lines visible above/below the cursor when scrolling

" ------- Key Mapping ------- " 
nnoremap <leader>ff :Files<CR> | " Open FZF fuzzy finder

" ---- CTAGS --- "
set tags=./tags;/		" Looks for tags file in current dir 
autocmd BufWritePost *.py silent! !ctags -R --languages=python --exclude=venv --exclude=.git --exclude=static .
