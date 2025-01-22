" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" ------ BASIC VIM SETTINGS --- " 
set number			" Show line numbers
set scrolloff=8			" Keep 8 lines visible above/below the cursor when scrolling

" ---- CTAGS --- "
set tags=./tags;/		" Looks for tags file in current dir 
autocmd BufWritePost *.py silent! !ctags -R --languages=python --exclude=venv --exclude=.git --exclude=static .
