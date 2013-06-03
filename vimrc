" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" =============================================================================
"                          << 以下为软件默认配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Windows Gvim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set diffexpr=MyDiff()

    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

" -----------------------------------------------------------------------------
"  < 颜色配置 >
" -----------------------------------------------------------------------------
"Color Settings {
set colorcolumn=85           "彩色显示第85行
set t_Co=256                 "设置256色显示
set background=dark          "使用color solarized
set cmdheight=2              "设置命令行的高度为2，默认为1
set cursorline               "设置光标高亮显示
set cursorcolumn             "光标垂直高亮
set ttyfast
set ruler
set backspace=indent,eol,start

" -----------------------------------------------------------------------------
"  < 主题配置 >
" -----------------------------------------------------------------------------
" 注：主题使用solarized
colorscheme solarized "desert 
let g:solarized_termtrans  = 1
let g:solarized_termcolors = 256
let g:solarized_contrast   = "high"
let g:solarized_visibility = "high"
"}

"tab setting {
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
"}

" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1		"设置支持打开的文件的编码
set scrolloff=3
set fenc=utf-8
set autoindent
set hidden
set encoding=utf-8				"设置gvim内部编码

" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新文件的<EOL>格式
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型

if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
    language messages zh_CN.utf-8
endif

" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
set laststatus=2							  "启用状态栏信息
set number                                    "显示行号
"set undofile                                  "无限undo
"set nowrap                                    "禁止自动换行
autocmd! bufwritepost _vimrc source %         "自动载入配置文件不需要重启

"set relativenumber                             "相对行号 要想相对行号起作用要放在显示行号后面
set wrap                                       "自动换行
if(g:iswindows)
	set guifont=YaHei_Consolas_Hybrid:h10                 "设置字体:字号（字体名称空格用下划线代替）
else
	set guifont=DejaVu\ Sans\ Mono\ 11                    "GUI界面里的字体，默认有抗锯齿
endif

set isk+=-                                     "将-连接符也设置为单词

set ignorecase "设置大小写敏感和聪明感知(小写全搜，大写完全匹配)
set smartcase
"set gdefault
set incsearch
set showmatch
set hlsearch

set numberwidth=4          "行号栏的宽度
set columns=135           "初始窗口的宽度
set lines=50              "初始窗口的高度
winpos 620 45             "初始窗口的位置

set whichwrap=b,s,<,>,[,]  "让退格，空格，上下箭头遇到行首行尾时自动移到下一行（包括insert模式）

" -----------------------------------------------------------------------------
"  < 其它配置 >
" -----------------------------------------------------------------------------
set writebackup                             "保存文件前建立备份，保存成功后删除该备份
set nobackup                                "设置无备份文件
" set noswapfile                              "设置无临时文件
" set vb t_vb=                                "关闭提示音
set showcmd                                 "设置显示命令

"插入模式下移动
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
inoremap <c-h> <left>

"===================================================
"修改leader键为逗号
let mapleader=","
imap jj <esc>

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"修改vim的正则表达
nnoremap / /\v
vnoremap / /\v

"使用tab键来代替%进行匹配跳转
nnoremap <tab> %
vnoremap <tab> %

"折叠html标签 ,fold tag
nnoremap <leader>ft vatzf
"使用,v来选择刚刚复制的段落，这样可以用来缩进
nnoremap <leader>v v`]

"使用,w来垂直分割窗口，这样可以同时查看多个文件,如果想水平分割则<c-w>s
"nnoremap <leader>w <c-w>v<c-w>l
"nnoremap <leader>wc <c-w>c
"nnoremap <leader>ww <c-w>w

"tab切换
nnoremap <leader>t gt
nnoremap <leader>r gT
"使用<leader>空格来取消搜索高亮
nnoremap <leader><space> :noh<cr>

"html中的js加注释 取消注释
nmap <leader>h I//jj
nmap <leader>ch ^xx
"切换到当前目录
nmap <leader>q :execute "cd" expand("%:h")<CR>
"搜索替换
nmap <leader>s :,s///c

"取消粘贴缩进
nmap <leader>p :set paste<CR>
nmap <leader>pp :set nopaste<CR>

"文件类型切换
nmap <leader>fj :set ft=javascript<CR>
nmap <leader>fc :set ft=css<CR>
nmap <leader>fx :set ft=xml<CR>
nmap <leader>fm :set ft=mako<CR>

"设置隐藏gvim的菜单和工具栏 F2切换
set guioptions-=m
set guioptions-=T
"去除左右两边的滚动条
set go-=r
set go-=L

map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

"Indent Guides设置
"let g:indent_guides_guide_size=1

if(!g:iswindows)
	"##### auto fcitx #####
	let g:input_toggle = 1
	function! Fcitx2en()
	    let s:input_status = system("fcitx-remote")
	    if s:input_status == 2
	        let g:input_toggle = 1
	        let l:a = system("fcitx-remote -c")
	    endif
	endfunction

	function! Fcitx2zh()
	    let s:input_status = system("fcitx-remote")
	    if s:input_status != 2 && g:input_toggle == 1
	        let l:a = system("fcitx-remote -o")
	        let g:input_toggle = 0
	    endif
	endfunction

	set timeoutlen=1500
	"退出插入模式
	autocmd InsertLeave * call Fcitx2en()
	"进入插入模式
	autocmd InsertEnter * call Fcitx2zh()
	"##### auto fcitx end #####
endif

" =============================================================================
"                          << 以下为用户自定义配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Vundle 插件管理工具配置 >
" -----------------------------------------------------------------------------
" 用于更方便的管理vim插件，具体用法参考 :h vundle 帮助
" 安装方法为在终端输入如下命令
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

set nocompatible          "禁用 Vi 兼容模式
filetype off              "禁用文件类型侦测,必须的设置

"Vundle Settings {
if !g:iswindows
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'ctrlp.vim'
Bundle 'AutoClose'
Bundle 'ZenCoding.vim'
Bundle 'matchit.zip'
Bundle 'Tabular'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'spiiph/vim-space'
Bundle 'trailing-whitespace'

Bundle '_jsbeautify'
nnoremap <leader>_ff :call g:Jsbeautify()<CR>

Bundle 'EasyMotion'
let g:EasyMotion_leader_key = '<Leader><Leader>'

"Fencview的初始设置
Bundle 'FencView.vim'
let g:fencview_autodetect=1

Bundle 'The-NERD-tree'
"设置相对行号
nmap <leader>nt :NERDTree<cr>:set rnu<cr>
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.$','\~$']
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos=1

Bundle 'The-NERD-Commenter'
let NERDShutUp=1
"支持单行和多行的选择，//格式
map <c-h> ,c<space>

Bundle 'UltiSnips'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

Bundle 'Markdown'
Bundle 'Markdown-syntax'
let g:vim_markdown_folding_disabled=1

Bundle 'instant-markdown.vim'
let g:instant_markdown_slow = 1

"带折叠双栏树状文本管理
Bundle 'VOoM'
Bundle 'TxtBrowser'
Bundle 'ctags.vim'
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'

Bundle 'ywtxt'

Bundle 'taglist.vim'

"js html 混排格式增强
Bundle 'pangloss/vim-javascript'

Bundle 'vimwiki'
let g:vimwiki_list=[{"path":"~/Notes/wiki/src/","path_html":"~/Notes/wiki/html/","auto_export":1}]

Bundle 'sketch.vim'

Bundle 'VimOrganizer'

Bundle 'Indent-Guides'
let g:indent_guides_guide_size=1

Bundle 'calendar.vim'

"}

"放置在Bundle的设置后，防止意外BUG
filetype plugin indent on                             "启用缩进
syntax on

"VimOrganizer setup
if(!g:iswindows)
    let g:org_agenda_select_dirs=["~/Notes/VimOrganizer/org_files"]
    let g:agenda_files = split(glob("~/Notes/VimOrganizer/org_files/org-mod*.org"),"\n")
    au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
    au BufEnter *.org            call org#SetOrgFileType()
endif
