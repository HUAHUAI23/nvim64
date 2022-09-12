" vim configuration

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
:autocmd BufNewFile,BufRead *.html setlocal nowrap
"Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h
"设置快捷键 shift o 进入粘贴模式，shift p退出粘贴模式，粘贴模式可以防止从网页复制内容到vim而出现奇怪的缩进问题，因为vim的缩减处理和一般文本编辑器不一样
"<cr>是enter键
"get crrect comment highlighting for json
autocmd FileType json syntax match Comment +\/\/.\+$+

let &t_ut=''
let &t_ul=''
set autochdir

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
let g:deus_termcolors=256

hi NonText ctermfg=gray guifg=grey50

hi SignColumn ctermbg=None guibg=None
hi VertSplit ctermfg=None ctermbg=None cterm=None guibg=None guifg=None
