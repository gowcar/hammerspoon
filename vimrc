"安装Plug插件管理
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
set nocompatible
set number
set guifont=Monaco:h16
"#显示行号
set nowrap
"不产生交换文件
set noswapfile
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
" 设置<Leader>键"
let mapleader=";"



" set relativenumber
"# 自动缩进
" colorscheme evening
" vim-plug 设置
call plug#begin('~/.vim/plugged')
" Plug 'chriskempson/base16-vim'
" Plug 'whatyouhide/vim-gotham'
" Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'fholgado/minibufexpl.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" Plug 'jistr/vim-nerdtree-tabs'
" Plug 'Nopik/vim-nerdtree-direnter'
" Plug 'jistr/vim-nerdtree-tabs'
Plug 'rustushki/JavaImp.vim'

call plug#end()
"NERD Tree
let NERDChristmasTree=0
let NERDTreeAutoCenter=1
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=0
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='left'
let NERDTreeWinSize=31
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nnoremap <C-N> :NERDTreeToggle<cr>

"nnoremap <C-H> :NERDTreeTabsToggle<cr>
"noremap <c-n> :b 
" let g:nerdtree_tabs_open_on_console_startup=0
" let g:nerdtree_tabs_autofind=1
" let NERDTreeCustomOpenArgs={'file':{'where': 't'}}
" let NERDTreeMapOpenInTab='<ENTER>'

autocmd vimenter * NERDTree
autocmd BufWinEnter * NERDTreeMirror
autocmd VimEnter * wincmd w

"设置YCM不显示预览窗口
set completeopt-=preview
"set completeopt=menu
"

let g:ycm_seed_identifiers_with_syntax=1  
" 修改对C函数的补全快捷键，默认是CTRL + space，修改为ALT + ;  
let g:ycm_key_invoke_completion = '…'
" 设置转到定义处的快捷键为ALT + G，这个功能非常赞  
nmap <D-j> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>  
"设置回车选择候选字
let g:ycm_key_list_stop_completion = ['<CR>']

let g:JavaImpPaths =
    \ $HOME . "/workspaces/jiaxin.gitlab/bridge-data-service/src/main/java," .
    \ $HOME . "/project2/javasrc," .
    \ $HOME . "/project3/javasrc"
let g:JavaImpDataDir = $HOME . "/.vim/JavaImp"
let g:JavaImpBottomImports = []
let g:JavaImpSortPkgSep = 0
nmap <leader>j :JI

"nnoremap <C-J> :ToggleBufExplorer<CR>
nnoremap gw :Gw<CR>
nnoremap gr :Gr<bar>:w<CR>
nnoremap gs :Gstatus<CR>
nnoremap gm :Gcommit<CR>
nnoremap gp :Gpush<CR>

nnoremap ∑ :MBEbd<CR>
"nnoremap <D-r> :MBEbd<CR>
nnoremap ff :LeaderfFile<CR>
nnoremap fo :LeaderfBuffer<CR>
nnoremap mm :MBEToggle<CR>
"ALT + H
nnoremap ˙ :MBEbp<CR>
"ALT + L
nnoremap ¬ :MBEbn<CR>
nnoremap <C-h>     <C-W>h
nnoremap <C-l>     <C-W>l
nnoremap <C-k>     <C-W>k
nnoremap <C-j>     <C-W>j
nmap ,n :NERDTreeFind<CR>
let g:miniBufExplorerAutoStart = 1
let g:miniBufExplBuffersNeeded = 1
"弹窗显示结果
" let g:Lf_WindowPosition = 'popup'
"搜索当前文件的方法
" nmap fo :LeaderfFunction<CR>

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

function! s:close_gstatus()
	for l:winnr in range(1, winnr('$'))
		if !empty(getwinvar(l:winnr, 'fugitive_status'))
			execute l:winnr.'close'
		endif
	endfor
endfunction
command! GstatusClose call s:close_gstatus()
nmap <leader>r :source $MYVIMRC<CR>
