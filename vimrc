set nocompatible			  " be iMproved, required
filetype off				  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" 注释gcc
Plugin 'tpope/vim-commentary'
" 全局选择插件
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-entire'
" 括号补全
Plugin 'jiangmiao/auto-pairs'
" 左侧目录
Plugin 'scrooloose/nerdtree'
" 符号操作
Plugin 'tpope/vim-surround'
" 快速移动插件
Plugin 'easymotion/vim-easymotion'
" 右边方法提示条
Plugin 'majutsushi/tagbar'

" buffer 插件
" Plugin 'fholgado/minibufexpl.vim'
"配色
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'


Plugin 'Lokaltog/vim-powerline'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab'
Plugin 'airblade/vim-gitgutter'


call vundle#end()			 " required
filetype plugin indent on	 " required

"设置帮助为中文文档
set helplang=cn

" 定义快捷键的前缀，即<Leader>
let mapleader=";"
" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on
" Buffer custom
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
set hidden
" 保存折叠状态
" 恢复折叠状态
au BufWinEnter * silent! loadview
au BufWinLeave * silent! mkview
" 当在vim的命令行提示符之后输入%%时，它就会自动展开为活动缓冲区所在的文件的路径
cnoremap <expr> %% getcmdtype(	) == ':' ? expand('%:h').'/' : '%%'
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%
" Shortcut to rapidly toggle `set list`
nmap ,l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬"
"Invisible character colors 
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
" 编辑模式下设置
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^
inoremap <C-f> <C-o>w
inoremap <C-g> <C-o>b

" Tab set
set ts=4 sts=4 sw=4 noexpandtab

" 设置 tabstop, softtabstop and shiftwidth 一个相同的值
" :Stap 4
" convert tabs to spaces
" :set expandtab
" :retab!
" spaces to tabs
" :set noexpandtab
" :retab!
command! -nargs=* Stab call Stab()
function! Stab()
	let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
	if l:tabstop > 0
		let &l:sts = l:tabstop
		let &l:ts = l:tabstop
		let &l:sw = l:tabstop
	endif
	call SummarizeTabs()
endfunction

function! SummarizeTabs()
	try
		echohl ModeMsg
		echon 'tabstop='.&l:ts
		echon ' shiftwidth='.&l:sw
		echon ' softtabstop='.&l:sts
		if &l:et
			echon ' expandtab'
		else
			echon ' noexpandtab'
		endif
	finally
		echohl None
	endtry
endfunction

" Only do this part when compiled with support for autocommands
" :set filetype=xml
" :setfiletype xml
if has("autocmd")
	" Enable file type detection
	filetype on

	" Syntax of these languages is fussy over tabs Vs spaces
	autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
	autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

	" Customisations based on house-style (arbitrary)
	autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

	" Treat .rss files as XML
	autocmd BufNewFile,BufRead *.rss, *.atom setfiletype xml
endif

function! Preserve(command)
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business:
	execute a:command
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction 
" 删除尾部空格
nmap <F5> :call Preserve("%s/\\s\\+$//e")<CR>
" 删除空行
nmap <F4> :call Preserve("g/^$/d")<CR>
" 对齐
nmap <Leader>= :call Preserve("normal gg=G")<CR>

" 切换多windows窗口上下左右
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" 关闭窗口
noremap <silent> <Leader>cj :wincmd j<CR>:close<CR>
noremap <silent> <Leader>ck :wincmd k<CR>:close<CR>
noremap <silent> <Leader>ch :wincmd h<CR>:close<CR>
noremap <silent> <Leader>cl :wincmd l<CR>:close<CR>
noremap <silent> <Leader>cc :close<CR>
noremap <silent> <Leader>s8 :vertical resize 83<CR>
noremap <silent> <Leader>cw :cclose<CR>
noremap <silent> <Leader>sl <C-W>L
noremap <silent> <Leader>sk <C-W>K
noremap <silent> <Leader>sh <C-W>H
noremap <silent> <Leader>sj <C-W>J

" Plugin EaseMotion
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p
" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
nmap qq :q<CR>
nmap <Leader>Q :qa!<CR>
nmap <Leader>q :wq<CR>
nmap <Leader>WQ :wa<CR>:q<CR>
" 定义快捷键在结对符之间跳转
nmap <Leader>m %

" let's try this out
imap jj <esc>
cmap jj <esc>
" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" vim 自身命令行模式智能补全
set wildmenu
set wildmode=full

"设置命令的缺省记录
set history=200
"把历史命令查找的便捷性结合一下
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" 配色方案
syntax enable
if has('gui_running')
	set background=light
else
	set background=dark
endif
colorscheme solarized
" colorscheme molokai
" colorscheme phd

" 禁止光标闪烁
set gcr=a:block-blinkon0
" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch

" 禁止折行
set nowrap

" 设置状态栏主题风格
let g:Powerline_colorscheme='solarized256'

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" 自适应不同语言的智能缩进
filetype indent on
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle

" 基于缩进或语法进行代码折叠
set foldmethod=indent
"set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable

" " signature plugin
" let g:SignatureMap = {
" 			\ 'Leader'			   :  "m",
" 			\ 'PlaceNextMark'	   :  "m,",
" 			\ 'ToggleMarkAtLine'   :  "m.",
" 			\ 'PurgeMarksAtLine'   :  "m-",
" 			\ 'DeleteMark'		   :  "dm",
" 			\ 'PurgeMarks'		   :  "mda",
" 			\ 'PurgeMarkers'	   :  "m<BS>",
" 			\ 'GotoNextLineAlpha'  :  "']",
" 			\ 'GotoPrevLineAlpha'  :  "'[",
" 			\ 'GotoNextSpotAlpha'  :  "`]",
" 			\ 'GotoPrevSpotAlpha'  :  "`[",
" 			\ 'GotoNextLineByPos'  :  "]'",
" 			\ 'GotoPrevLineByPos'  :  "['",
" 			\ 'GotoNextSpotByPos'  :  "mn",
" 			\ 'GotoPrevSpotByPos'  :  "mp",
" 			\ 'GotoNextMarker'	   :  "[+",
" 			\ 'GotoPrevMarker'	   :  "[-",
" 			\ 'GotoNextMarkerAny'  :  "]=",
" 			\ 'GotoPrevMarkerAny'  :  "[=",
" 			\ 'ListLocalMarks'	   :  "ms",
" 			\ 'ListLocalMarkers'   :  "m?"
" 			\ }

" 设置 tagbar 子窗口的位置出现在主编辑区的左边 
let tagbar_left=0 
" 设置显示／隐藏标签列表子窗口的快捷键。速记：tag list 
nnoremap <Leader>tl :TagbarToggle<CR> 
" 设置标签子窗口的宽度 
let tagbar_width=32 
" tagbar 子窗口中不显示冗余帮助信息 
let g:tagbar_compact=0


" 使用 ctrlsf.vim
" 插件在工程内全局查找光标所在关键字，设置快捷键。快捷键速记法：search in
" project
nnoremap <Leader>sp :CtrlSF<CR>

" 替换函数。参数说明：
" confirm：是否替换前逐一确认
" wholeword：是否整词匹配
" replace：被替换字符串
function! Replace(confirm, wholeword, replace)
	wa
	let flag = ''
	if a:confirm
		let flag .= 'gec'
	else
		let flag .= 'ge'
	endif
	let search = ''
	if a:wholeword
		let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
	else
		let search .= expand('<cword>')
	endif
	let replace = escape(a:replace, '/\&~')
	execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
" 不确认、非整词
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 不确认、整词
nnoremap <Leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、非整词
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、整词
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>

" 使用 NERDTree 。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="left"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1

" 显示/隐藏 MiniBufExplorer 窗口
map <Leader>bl :MBEToggle<cr>
" buffer 切换快捷键
map <C-Tab> :MBEbn<cr>
map <C-S-Tab> :MBEbp<cr>

" 设置环境保存项
set sessionoptions="blank,buffers,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize"
" 保存 undo 历史
set undodir=~/.undo_history/
set undofile
" 保存快捷键
map <leader>ss :mksession! my.vim<cr> :wviminfo! my.viminfo<cr>
" 恢复快捷键
map <leader>rs :source my.vim<cr> :rviminfo my.viminfo<cr>

" 快捷键
map <SPACE> <Plug>(wildfire-fuel)
vmap <S-SPACE> <Plug>(wildfire-water)
" 适用于哪些结对符
let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "i>", "ip"]
" 调用 gundo 树
nnoremap <Leader>ud :GundoToggle<CR>
" 开启保存 undo 历史功能
set undofile
" " undo 历史保存路径
set undodir=~/.undo_history/

xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
	let temp = @s
	norm! gv"sy
	let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
	let @s = temp
endfunction
