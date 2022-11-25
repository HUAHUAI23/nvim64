" ---vim configuration
" ---打开文件光标回到之前的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" --- html 文件禁止折行
:autocmd BufNewFile,BufRead *.html setlocal nowrap
" ---Auto change directory to current dir
" autocmd BufEnter * silent! lcd %:p:h
" ---get crrect comment highlighting for json
autocmd FileType json syntax match Comment +\/\/.\+$+

let &t_ut=''
let &t_ul=''
" set autochdir

"Display some invisual characters like space tab etc
" set list "set nolist
" set how invisual characters forms display
" set listchars=tab:\|\ ,trail:▫

" nvim 主题设置，主题采用deus，需提前安装好deus

set t_Co=256
" set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" set background=dark
" color deus
" let g:deus_termcolors=256

hi NonText ctermfg=gray guifg=grey50

hi SignColumn ctermbg=None guibg=None
hi VertSplit ctermfg=None ctermbg=None cterm=None guibg=None guifg=None

" ----------plugin------------
" -----undo tree
if has("persistent_undo")
    let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
