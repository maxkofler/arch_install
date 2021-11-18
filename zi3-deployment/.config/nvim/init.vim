" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/site/plugged')
" Declare the list of plugins.
Plug 'vim-airline/vim-airline'
" Visual Settings
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" Color theme plugins
Plug 'joshdick/onedark.vim'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""
" Color Settings
"""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
colorscheme onedark
