inoremap jk <Esc>
vnoremap jk <Esc>
xnoremap jk <Esc>
inoremap jj <Esc>

set relativenumber
set nopaste
" ==============================
" Suche
" ==============================
set incsearch           " Inkrementelle Suche
set ignorecase          " Groß-/Kleinschreibung ignorieren
set smartcase           " Außer bei Großbuchstaben
set hlsearch            " Suchergebnisse hervorheben

let mapleader=" "

" Build and Debug Settings
nnoremap <leader>r :vsc Build.BuildSolution<CR>
nnoremap <leader>d :vsc Debug.Start<CR>
nnoremap <leader>b :vsc Debug.ToggleBreakpoint<CR>

" Jump-Liste wie in Neovim
nnoremap <C-o> :vsc View.NavigateBackward<CR>
nnoremap <C-i> :vsc View.NavigateForward<CR>

" Finding stuff
nnoremap <leader>sg :vsc Edit.NavigateTo<CR>
nnoremap grr :vsc Edit.FindAllReferences<CR><Esc>
nnoremap grd :vsc Edit.GoToDefinition<CR><Esc>
nnoremap grD :vsc Edit.GoToDeclaration<CR><Esc>

set timeoutlen=500
set noerrorbells
