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
"�����к�
set nu
"�Զ�����ļ�����
filetype plugin indent on
"�﷨����
syntax on
"�Զ�����
set autoindent
"���� Backspace �� Delete �����̶ȣ�backspace=2 ��û���κ�����
"��������Щģʽ��ʹ����깦�ܣ�mouse=a ��ʾ����ģʽ
set mouse=a
set backspace=2
"���Զ�����
set nowrap
"���ó���100�ַ��Զ�����
"set textwidth=100
"���ó���100�е��ַ����»���
"au BufWinEnter * let w:m2=matchadd('Underlined', '\%>100v.\+', -1)
"syn match out80 /\%80v./ containedin=ALL
"hi out80 guifg=white guibg=red
"���ܶ��뷽ʽ
set smartindent
"һ��tab��4���ַ�
set tabstop=4
"��һ��tabǰ��4���ַ�
set softtabstop=4
"�ÿո����tab
set expandtab
"�����Զ�����
set ai!
"�������ַ�����
set cindent shiftwidth=4
"set autoindent shiftwidth=2
"�򿪹�������λ����ʾ����
set ruler
"��ʾ��������
set ambiwidth=double
"�и���
set cursorline
"�и������뺯���б��г�ͻ
set cursorcolumn
"���������еĸ߶�
set cmdheight=2
"���������Ĺؼ���
set hlsearch
"�������Դ�Сд
set ignorecase
"����������ʷ����
set history=100
"�����Զ�����
set wrap
"������ʱ����ʾ�Ǹ�Ԯ���������ͯ����ʾ
set shortmess=atI
"��Ҫ��˸
"set novisualbell
" ��Ҫ����swap�ļ�����buffer��������ʱ��������
setlocal noswapfile
set bufhidden=hide
"��ʾTAB��
"set list
"set listchars=tab:>-,trail:-
"����VIM״̬��
set laststatus=2 "��ʾ״̬��(Ĭ��ֵΪ1, �޷���ʾ״̬��)
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
"��ǿģʽ�е��������Զ���ɲ���
set wildmenu
"ִ�� Vim ȱʡ�ṩ�� .vimrc �ļ���ʾ���������˴��﷨������ʾ����õĹ���
source $VIMRUNTIME/vimrc_example.vim
"ȱʡ�����������ļ�
set nobackup
set noswapfile
set nowritebackup
"����������ʱ������ݵ�������֮��ƥ������Ŵ�����Ӱ������
set showmatch
"��ȷ�ش��������ַ������к�ƴ��
set formatoptions+=mM
"�趨�ļ������Ŀ¼Ϊ��ǰĿ¼
set bsdir=buffer
"�Զ��л���ǰĿ¼Ϊ��ǰ�ļ����ڵ�Ŀ¼
set autochdir
"�Զ����¼����ⲿ�޸�����
"set autoread
"ʹPHPʶ��EOT�ַ���
hi link phpheredoc string
"��������δ������޸�ʱ�л�������
set hidden
"���뵱ǰ�༭���ļ���Ŀ¼
autocmd BufEnter * exec "cd %:p:h"
"�����ļ��ĸ�ʽ˳��
set fileformats=unix,dos
"��ɫ���������ɫ��colorsĿ¼��http://www.cs.cmu.edu/~maverick/VimColorSchemeTest/index-c.html��
"colorscheme peacock_light
set background=dark
colorscheme solarized
"��ճ��ģʽ������ճ�������ĳ������Ͳ����λ�ˡ�
"set paste
"��¼�ϴιرյ��ļ���״̬
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
"html�Զ�����ƥ���ǩ������>֮���Զ����ƥ���ǩ
"au FileType xhtml,xml so ~/.vim/ftplugin/html_autoclosetag.vim
"F7�����л���nerd_tree��nerd_tree�����
let g:NERDChristmasTree = 1              "ɫ����ʾ
let g:NERDTreeShowHidden = 1             "��ʾ�����ļ�
let g:NERDTreeWinPos = 'left'            "������ʾλ��
let g:NERDTreeHighlightCursorline = 0    "������ǰ��
nmap <C-F4>  :NERDTree<CR>
let g:SuperTabRetainCompletionType = 2
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"ƽ̨�ж�
function! GetSystem()
    if (has("win32") || has("win95") || has("win64") || has("win16"))
        return "windows"
    elseif has("unix")
        return "linux"
    elseif has("mac")
        return "mac"
    endif
endfunction
"F8�����л���taglist��taglist�����
if GetSystem() == "windows"
let g:Tlist_Ctags_Cmd = $VIMRUNTIME.'\ctags'
else
    let g:Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif
"let g:Tlist_Sort_Type = 'name'          "������˳������Ĭ����λ��˳��(order)
"let g:Tlist_Show_One_File = 1           "��ͬʱ��ʾ����ļ���tag��ֻ��ʾ��ǰ�ļ���
"let g:Tlist_Exit_OnlyWindow = 1         "���taglist���������һ�����ڣ����˳�vim
"lef g:Tlist_File_Fold_Auto_Close = 1    "����겻�ڱ༭�ļ������ʱ��ȫ���۵�
"let g:Tlist_Use_Right_Window = 1        "���Ҳര������ʾtaglist����
"let g:Tlist_Enable_Fold_Column = 1      "��ʾ�۵�����
"nmap <C-F8>  :TlistToggle<CR>
"F12����/����tags�ļ�
set tags=tags;
set autochdir
"Ctrl + F12ɾ��&&����tags�ļ�
function! DeleteTagsFile()
    "Linux�µ�ɾ������
    "silent !rm tags
    "Windows�µ�ɾ������
    silent !del /F /Q tags
    silent !ctags -R --languages=php,c --c-kinds=+p --fields=+ianS --extra=+q
endfunction
nmap <C-F12> :call DeleteTagsFile()<CR>
"�˳�VIM֮ǰɾ��tags�ļ�
"au VimLeavePre * call DeleteTagsFile()
""""""""""""""""""""""""""""""
" lookupfile setting
""""""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 2               "��������2���ַ��ſ�ʼ����
let g:LookupFile_PreserveLastPattern = 0        "�������ϴβ��ҵ��ַ���
let g:LookupFile_PreservePatternHistory = 1     "���������ʷ
let g:LookupFile_AlwaysAcceptFirst = 1          "�س��򿪵�һ��ƥ����Ŀ
let g:LookupFile_AllowNewFiles = 0              "�������������ڵ��ļ�
if filereadable("./filenametags")                "����tag�ļ�������
let g:LookupFile_TagExpr = '"./filenametags"'
endif
"ӳ��LookupFileΪ,lk
nmap <silent> <leader>lk :LUTags<cr>
"ӳ��LUBufsΪ,ll
nmap <silent> <leader>ll :LUBufs<cr>
"ӳ��LUWalkΪ,lw
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
