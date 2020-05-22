set nocompatible
set number
set guifont=Monaco:h16
"#显示行号
set nowrap
"#不换行
set shiftwidth=4
"#默认缩进4个空格
set softtabstop=2
"#使用tab时 tab空格数
set tabstop=2
"#tab代表4个空格
set laststatus=2
"#总是显示状态行
"#backspace键
"# indent 删除自动缩进的值
"# eol 删除上一行行末尾的回车，两行合并
"# start 除了刚输入的，还删除原来的字符
set backspace=indent,eol,start
set expandtab
"#使用空格替换tab
set autoindent
" set relativenumber
"# 自动缩进
" colorscheme evening
" vim-plug 设置
call plug#begin('~/.vim/plugged')
" Plug 'chriskempson/base16-vim'
" Plug 'whatyouhide/vim-gotham'
" Plug 'vim-airline/vim-airline'
 Plug 'scrooloose/nerdtree'
 Plug 'jistr/vim-nerdtree-tabs'
" Plug 'jistr/vim-nerdtree-tabs'
call plug#end()
"NERD Tree
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='left'
let NERDTreeWinSize=31
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"nnoremap <C-H> :NERDTreeToggle<cr>
nnoremap <C-H> :NERDTreeTabsToggle<cr>
noremap <c-n> :b 
let g:nerdtree_tabs_open_on_console_startup=1 
let g:nerdtree_tabs_autofind=1
let NERDTreeMapOpenInTab='<ENTER>'

" autocmd vimenter * NERDTree
" autocmd BufWinEnter * NERDTreeMirror
" autocmd VimEnter * wincmd w


" 使用 256 颜色库
" let base16colorspace=256
" 使用 base16 中 base16-oceanicnext
" colorscheme base16-oceanicnext
colorscheme desert
" vim-plug 设置

" 使用 gotham 配色
" colorscheme gotham
"#颜色模式
syn on
"#语法高亮
filetype on
"#文件类型
" highlight LineNr cterm=bold ctermfg=red
set encoding=utf-8 " #编码为utf8

