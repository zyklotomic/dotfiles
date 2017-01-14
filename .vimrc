set relativenumber
set number
set showcmd
set cursorline
set lazyredraw " redraw only when we need to
set showmatch " highlight matching for parentheses
" Searching
set incsearch "search as characters are entered
set hlsearch " highlight matches

" Scrolling
set scrolloff=3 " Keep 3 lines below and above the cursor


" Editing
syntax enable 
filetype indent on " load filetype-specific ident files
set expandtab " tabs are spaces

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Folding 
set foldenable " enable folding


colorscheme gruvbox
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1
let g:gruvbox_contrast_dark='medium'
set background=dark
