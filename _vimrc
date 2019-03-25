set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'kannokanno/previm'
Plugin 'tyru/open-browser.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'

call vundle#end()
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
"autocmd vimenter * NERDTree
behave mswin
set showtabline=2
" Multi-encoding setting, MUST BE IN THE BEGINNING OF .vimrc!
"
if has("multi_byte")
    " When 'fileencodings' starts with 'ucs-bom', don't do this manually
    "set bomb
    set fileencodings=ucs-bom,utf-8,chinese,taiwan,japan,korea,latin1
    " CJK environment detection and corresponding setting
    if v:lang =~ "^zh_CN"
        " Simplified Chinese, on Unix euc-cn, on MS-Windows cp936
        set encoding=chinese
        if &fileencoding == ''
            set fileencoding=chinese
        endif
    elseif v:lang =~ "^zh_TW"
        " Traditional Chinese, on Unix euc-tw, on MS-Windows cp950
        set encoding=taiwan
        set termencoding=taiwan
        if &fileencoding == ''
            set fileencoding=taiwan
        endif
    elseif v:lang =~ "^ja_JP"
        " Japanese, on Unix euc-jp, on MS-Windows cp932
        set encoding=japan
        set termencoding=japan
        if &fileencoding == ''
            set fileencoding=japan
        endif
    elseif v:lang =~ "^ko"
        " Korean on Unix euc-kr, on MS-Windows cp949
        set encoding=korea
        set termencoding=korea
        if &fileencoding == ''
            set fileencoding=korea
        endif
    endif
    " Detect UTF-8 locale, and override CJK setting if needed
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
        set encoding=utf-8
    endif
else
    echoerr 'Sorry, this version of (g)Vim was not compiled with "multi_byte"'
endif
set guifont=Ubuntu\ Mono\ derivative\ Powerline:h15
set diffexpr=MyDiff()
function! MyDiff()
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
"设置行号
set nu
"自动检测文件类型
filetype plugin indent on
"语法高亮
syntax on
"自动缩进
set autoindent
"设置 Backspace 和 Delete 的灵活程度，backspace=2 则没有任何限制
"设置在哪些模式下使用鼠标功能，mouse=a 表示所有模式
set mouse=a
set backspace=2
"不自动换行
set nowrap
"设置超过100字符自动换行
"set textwidth=100
"设置超过100列的字符带下划线
"au BufWinEnter * let w:m2=matchadd('Underlined', '\%>100v.\+', -1)
"syn match out80 /\%80v./ containedin=ALL
"hi out80 guifg=white guibg=red
"智能对齐方式
set smartindent
"一个tab是4个字符
set tabstop=4
"按一次tab前进4个字符
set softtabstop=4
"用空格代替tab
set expandtab
"设置自动缩进
set ai!
"缩进的字符个数
set cindent shiftwidth=4
"set autoindent shiftwidth=2
"打开光标的行列位置显示功能
set ruler
"显示中文引号
set ambiwidth=double
"行高亮
set cursorline
"列高亮，与函数列表有冲突
set cursorcolumn
"设置命令行的高度
set cmdheight=2
"高亮搜索的关键字
set hlsearch
"搜索忽略大小写
set ignorecase
"设置命令历史行数
set history=100
"设置自动换行
set wrap
"启动的时候不显示那个援助索马里儿童的提示
set shortmess=atI
"不要闪烁
"set novisualbell
" 不要生成swap文件，当buffer被丢弃的时候隐藏它
setlocal noswapfile
set bufhidden=hide
"显示TAB健
"set list
"set listchars=tab:>-,trail:-
"设置VIM状态栏
set laststatus=2 "显示状态栏(默认值为1, 无法显示状态栏)
set statusline=
set statusline+=%2*%-3.3n%0*\ " buffer number
set statusline+=%f\ " file name
set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=[
if v:version >= 600
    set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
    set statusline+=%{&fileencoding}, " encoding
endif
set statusline+=%{&fileformat}] " file format
set statusline+=%= " right align
"set statusline+=%2*0x%-8B\ " current char
set statusline+=0x%-8B\ " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset
if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
    set statusline+=\ %{VimBuddy()} " vim buddy
endif
"增强模式中的命令行自动完成操作
set wildmenu
"执行 Vim 缺省提供的 .vimrc 文件的示例，包含了打开语法加亮显示等最常用的功能
source $VIMRUNTIME/vimrc_example.vim
"缺省不产生备份文件
set nobackup
set noswapfile
set nowritebackup
"在输入括号时光标会短暂地跳到与之相匹配的括号处，不影响输入
set showmatch
"正确地处理中文字符的折行和拼接
set formatoptions+=mM
"设定文件浏览器目录为当前目录
set bsdir=buffer
"自动切换当前目录为当前文件所在的目录
set autochdir
"自动重新加载外部修改内容
"set autoread
"使PHP识别EOT字符串
hi link phpheredoc string
"允许在有未保存的修改时切换缓冲区
set hidden
"进入当前编辑的文件的目录
autocmd BufEnter * exec "cd %:p:h"
"保存文件的格式顺序
set fileformats=unix,dos
"配色（更多的配色见colors目录和http://www.cs.cmu.edu/~maverick/VimColorSchemeTest/index-c.html）
"colorscheme peacock_light
set background=dark
colorscheme solarized
"置粘贴模式，这样粘贴过来的程序代码就不会错位了。
"set paste
"记录上次关闭的文件及状态
set viminfo='10,\"100,:20,%,n~/_viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe"norm $"|endif|endif
"autocmd BufWinLeave * if expand('%') != '' && &buftype == '' | mkview | endif
"autocmd BufRead     * if expand('%') != '' && &buftype == '' | silent loadview | syntax on | endif
"You can obtain the completion dictionary file from:
"http://cvs.php.net/viewvc.cgi/phpdoc/funclist.txt
"set dictionary+=$VIM\vimfiles\syntax\function.txt
au FileType php setlocal dictionary+=$VIM\vimfiles\syntax\function.txt
if !exists('g:AutoComplPop_Behavior')
    let g:AutoComplPop_Behavior = {}
    let g:AutoComplPop_Behavior['php'] = []
    call add(g:AutoComplPop_Behavior['php'], {
            \   'command'   : "\<C-x>\<C-o>",
            \   'pattern'   : printf('\(->\|::\|\$\)\k\{%d,}$', 0),
            \   'repeat'    : 0,
            \})
endif
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap < <><ESC>i
:inoremap > <c-r>=ClosePair('>')<CR>
function! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
    else
    return a:char
  endif
endf
"Use the dictionary completion
"set complete-=k complete+=k
"html自动输入匹配标签，输入>之后自动完成匹配标签
"au FileType xhtml,xml so ~/.vim/ftplugin/html_autoclosetag.vim
"F7单独切换打开nerd_tree（nerd_tree插件）
let g:NERDChristmasTree = 1              "色彩显示
let g:NERDTreeShowHidden = 1             "显示隐藏文件
let g:NERDTreeWinPos = 'left'            "窗口显示位置
let g:NERDTreeHighlightCursorline = 0    "高亮当前行
nmap <C-F4>  :NERDTree<CR>
let g:SuperTabRetainCompletionType = 2
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"平台判断
function! GetSystem()
    if (has("win32") || has("win95") || has("win64") || has("win16"))
        return "windows"
    elseif has("unix")
        return "linux"
    elseif has("mac")
        return "mac"
    endif
endfunction
"F8单独切换打开taglist（taglist插件）
if GetSystem() == "windows"
let g:Tlist_Ctags_Cmd = $VIMRUNTIME.'\ctags'
else
    let g:Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif
"let g:Tlist_Sort_Type = 'name'          "以名称顺序排序，默认以位置顺序(order)
"let g:Tlist_Show_One_File = 1           "不同时显示多个文件的tag，只显示当前文件的
"let g:Tlist_Exit_OnlyWindow = 1         "如果taglist窗口是最后一个窗口，则退出vim
"lef g:Tlist_File_Fold_Auto_Close = 1    "当光标不在编辑文件里面的时候全部折叠
"let g:Tlist_Use_Right_Window = 1        "在右侧窗口中显示taglist窗口
"let g:Tlist_Enable_Fold_Column = 1      "显示折叠边栏
"nmap <C-F8>  :TlistToggle<CR>
"F12生成/更新tags文件
set tags=tags;
set autochdir
"Ctrl + F12删除&&更新tags文件
function! DeleteTagsFile()
    "Linux下的删除方法
    "silent !rm tags
    "Windows下的删除方法
    silent !del /F /Q tags
    silent !ctags -R --languages=php,c --c-kinds=+p --fields=+ianS --extra=+q
endfunction
nmap <C-F12> :call DeleteTagsFile()<CR>
"退出VIM之前删除tags文件
"au VimLeavePre * call DeleteTagsFile()
""""""""""""""""""""""""""""""
" lookupfile setting
""""""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
if filereadable("./filenametags")                "设置tag文件的名字
let g:LookupFile_TagExpr = '"./filenametags"'
endif
"映射LookupFile为,lk
nmap <silent> <leader>lk :LUTags<cr>
"映射LUBufs为,ll
nmap <silent> <leader>ll :LUBufs<cr>
"映射LUWalk为,lw
nmap <silent> <leader>lw :LUWalk<cr>
"call pathogen#infect()
let g:indent_guides_guide_size=1
set modelines=20
set confirm
"set cscopetag
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 30
nmap <C-F5> :TagbarToggle<CR>
nmap <C-F6> :Bufferlist<CR>
set complete=t
set display=lastline
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
