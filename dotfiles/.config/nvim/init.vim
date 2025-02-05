" ===================== VIMRC Configuration =====================
" Get the default configurations most users want
source $VIMRUNTIME/defaults.vim     " Load default Vim settings from runtime directory

" ===================== Auto-install VimPlug =====================
" Auto-download VimPlug plugin manager if not already installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ===================== Plugins =====================
" Declare plugins managed by VimPlug
call plug#begin()  " Initialize plugin block
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy Finder core
Plug 'junegunn/fzf.vim'                             " FZF Vim integration
call plug#end()  " End plugin block

" ===================== Basic Vim Settings =====================
" Interface settings
set number             " Show absolute line numbers
set relativenumber     " Show relative line numbers for easier navigation
set scrolloff=8        " Keep at least 8 lines visible above/below the cursor when scrolling

" ===================== Key Mappings =====================
" Define custom keybindings
let mapleader = " " 
nnoremap <leader>sf :Files<CR> |  " Open FZF fuzzy finder using <leader> + ff
nnoremap <leader>e :Ex<CR>     |  " Open NetRW file explorer using <leader> + e

" ===================== CTAGS Integration =====================
" Configure ctags for better navigation and auto-generation
set tags=./tags;/  " Search for tags file in current directory and upwards

" Automatically regenerate tags file when saving Python files
autocmd BufWritePost *.py silent! !ctags -R --languages=python --exclude=venv --exclude=.git --exclude=static .

" ===================== Notes =====================
" - <leader> is usually mapped to "\" by default. You can customize it as needed:
"   let mapleader = " "  " Uncomment this to use space as the leader key
" - Use `:PlugStatus` to verify the status of your plugins.
