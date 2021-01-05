"                                           _
"       ___ _ __   __ _  ___ ___     __   _(_)_ __ ___
"      / __| -_ \ / _- |/ __/ _ \____\ \ / / | -_ - _ \
"      \__ \ |_) | (_| | (_|  __/_____\ V /| | | | | | |
"      |___/ .__/ \__._|\___\___|      \_/ |_|_| |_| |_|
"          |_|
"
"   Copyright (c) 2017 Liu-Cheng Xu & Contributors
"
"   You can customize space-vim with .spacevim
"   and don't have to take care of this file.
"
"   Author: Liu-Cheng Xu <xuliuchengxlc@gmail.com>
"   URL: https://github.com/liuchengxu/space-vim
"   License: MIT

scriptencoding utf-8

let g:spacevim = get(g:, 'spacevim', {})
let g:spacevim.base = $HOME.'/.space-vim'
let g:spacevim.version = '0.9.0'

" Identify platform {
let g:spacevim.os = {}
let g:spacevim.os.mac = has('macunix')
let g:spacevim.os.linux = has('unix') && !has('macunix') && !has('win32unix')
let g:spacevim.os.windows = has('win32')
" }

" Windows Compatible {
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if g:spacevim.os.windows
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif
" }

set runtimepath+=$HOME/.space-vim/core

call spacevim#bootstrap()


" ######################### user ##########################
" <leader> is whitespace
let mapleader = " "

" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
"   if has("autocmd")
"     au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"   endif

" Ranges
" The / address can be preceded with another address. This allows you to stack patterns, e.g.:
"   :/foo//bar//quux/d
" This would delete the first line containing "quux" after the first line containing "bar" after the first line containing "foo" after the current line.
" Sometimes Vim automatically prepends the command-line with a range. E.g. start a visual line selection with V,
"  select some lines and type :. The command-line will be populated with the range '<,'>, which means the following
"  command will use the previously selected lines as a range. (This is also why you sometimes see mappings like
"  :vnoremap foo :<c-u>command. Here <c-u> is used to remove the range, because Vim will throw an error when
"  giving a range to a command that doesn't support it.)
" Another example is using !! in normal mode. This will populate the command-line with :.!. If followed by an
"  external program, that program's output would replace the current line. So you could replace the current paragraph
"  with the output of ls by using :?^$?+1,/^$/-1!ls. Fancy!
" Help:
"   :h cmdline-ranges
"   :h 10.3

" show bracket pairs
"   set showmatch
set list
set nobackup

" scroll {
    " 在上下移动光标时，光标的上方或下方至少会保留显示的行数
    set scrolloff=7

    " 滚动Speed up scrolling of the viewport slightly
    nnoremap <C-e> 2<C-e>
    nnoremap <C-y> 2<C-y>
" }

" cursor {
    set cursorcolumn
    set cursorline
    " cursor colors
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" }

" Formatting {
    " convert tab to whitespace
    " 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
    set expandtab
    " indentation option
    " 设置Tab键的宽度        [等同的空格个数]
    set tabstop=4       " insert mode tab use 4 spaces
    " 按退格键时可以一次删掉 4 个空
    set shiftwidth=4    " indent 4 spaces when using >> or <<
    " 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
    set shiftround
    " insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
    set smarttab
    autocmd FileType haskell,puppet,ruby,yml
                \ setlocal expandtab shiftwidth=2 softtabstop=2   set softtabstop=4   " insert mode tab and backspace use 4 spaces "
" }

" quickfix {
    " In the quickfix window, <CR> is used to jump to the error under the
    " cursor, so undefine the mapping there.
    autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
    " quickfix window  s/v to open in split window,  ,gd/,jd => quickfix window => open it
    autocmd BufReadPost quickfix nnoremap <buffer> v <C-w><Enter><C-w>L
    autocmd BufReadPost quickfix nnoremap <buffer> s <C-w><Enter><C-w>K
    " 离开插入模式后自动关闭预览窗口
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" }

" number line {
    " 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
    set relativenumber number
    au FocusLost * :set norelativenumber number
    au FocusGained * :set relativenumber
    " 插入模式下用绝对行号, 普通模式下用相对
    autocmd InsertEnter * :set norelativenumber number
    autocmd InsertLeave * :set relativenumber
    function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber number
    else
        set relativenumber
    endif
    endfunc
    nnoremap <C-n> :call NumberToggle()<cr>
" }

" Reload a file on saving
"  au BufWritePost $MYVIMRC source $MYVIMRC

" Smarter cursorline
" I love the cursorline, but I only want to use it in the current window and not when being in insert mode:
"   autocmd InsertLeave,WinEnter * set cursorline
"   autocmd InsertEnter,WinLeave * set nocursorline

" Faster keyword completion
" The keyword completion (<c-n>/<c-p>) tries completing whatever is listed in the 'complete' option. By default,
"  this also includes tags (which can be annoying) and scanning all included files (which can be very slow). If you can live
"  without these things, disable them:
set complete-=i   " disable scanning included files
set complete-=t   " disable searching tags

" change region around brackets
onoremap in) :<c-u>normal! f)vi)<cr>
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap in} :<c-u>normal! f}vi}<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>

" Don't lose selection when shifting sidewards
" If you select one or more lines, you can use < and > for shifting them sidewards. Unfortunately you immediately lose the selection afterwards.
" You can use gv to reselect the last selection (see :h gv), thus you can work around it like this:
xnoremap > >gv
xnoremap < <gv
" <leader>g >>> search for word under current cursor to quickfix similar to
"   # and *
nnoremap <leader>g :<c-u>vimgrep <cword> % <cr>

" Quickly add empty lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
" Now 5[<space> inserts 5 blank lines above the current line.

" Quickly edit your macros
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
" Use it like this <leader>m or "q<leader>m.
" Notice the use of <c-r><c-r> to make sure that the <c-r> is inserted literally. See :h c_^R^R.

" Quickly jump to header or source file
" This technique can probably be applied to many filetypes. It sets file marks (see :h marks) when leaving a source or
"  header file, so you can quickly jump back to the last accessed one by using 'C or 'H (see :h 'A).
autocmd BufLeave *.{c,cpp} mark C
autocmd BufLeave *.h       mark H
autocmd BufLeave *.tcl     mark T
autocmd BufLeave *.pl      mark P
autocmd BufLeave *.sh      mark S
" NOTE: The info is saved in the viminfo file, so make sure that :set viminfo? includes :h viminfo-'.

" Quickly change font size in GUI
" I think this was taken from tpope's config:
command! Bigger  :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
command! Smaller :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')

" quickly move currentline down or up
"    nnoremap <leader>mu :<c-u>move -1- <cr>
"    nnoremap <leader>md :<c-u>move + <cr>
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>
" These mappings also take a count, so 2]e moves the current line 2 lines below.

" Getting help offline
"   :helpgrep backwards
" This will look for "backwards" in all documentation files and jump to the first match. The matches will be assembled in
"  the quickfix list. Use :cn/:cp to jump to the next/previous match. Or use :copen to open the quickfix window,
"  navigate to an entry and hit <cr> to jump to that match. See :h quickfix for the whole truth.
" This mapping is triggered by \h. If you want to use <space>h instead:
let mapleader = ' '
nnoremap <leader>h :helpgrep<space>

" Let us use our good old friend grep for searching the files in the current directory recursively for a certain query and put the results in the quickfix list.
let &grepprg = 'grep -Rn $* .'
"   :grep! foo
" <grep output - hit enter>
"   :copen

" Open a few windows and tabs and do
"   :mksession Foo.vi:dflokldfgk
" Restart Vim and do
"   :source Foo.vim
" Do some more work and update the session by overwriting the already existing session file with
"   :mksession! Foo.vim
" For scripting purposes Vim keeps the name of the last sourced or written session in the internal variable
"   v:this_session

" If you don't even want to specify the * register all the time, put this in your vimrc:
"   set clipboard=unnamed
" If you're even too lazy to type y, you can send every visual selection to the clipboard by using these settings:
set clipboard=unnamed,autoselect
set guioptions+=a

" If you happen to access one of the two registers all the time, consider using:
set clipboard^=unnamed      " * register
" or
set clipboard^=unnamedplus  " + register
" (The ^= is used to prepend to the default value, :h :set^=.)

" Restore cursor position when opening file
" The " mark contains the position in the buffer where you left off.
"  autocmd BufReadPost *
"      \ if line("'\"") > 1 && line("'\"") <= line("$") |
"      \   execute "normal! g`\"" |
"      \ endif

" Put all temporary files in their own directory under ~/.vim/files:
" create directory if needed
"    if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')
"      call mkdir($HOME.'/.vim/files')
"    endif
"    " backup files
"    set backup
"    set backupdir   =$HOME/.vim/files/backup/
"    set backupext   =-vimbackup
"    set backupskip  =
"    " swap files
"    set directory   =$HOME/.vim/files/swap//
"    set updatecount =100
"    " undo files
"    set undofile
"    set undodir     =$HOME/.vim/files/undo/
"    " viminfo files
"    set viminfo     ='100,n$HOME/.vim/files/info/viminfo

" Block insert
" Switch to visual block mode with <c-v>. Afterwards go down for a few lines. Hit <I> or <A> and start entering your text.
" If you have lines of different length and want to append the same text right after the end of each line, do this:
"   <c-v>3j$Atext<esc>

" Running external programs and using filters
" Use :! to start a job. If you want to list the files in the current working directory, use :!ls. Use | for piping in the shell as usual, e.g. :!ls -1 | sort | tail -n5.
" E.g. for prepending numbers to the next 5 lines, use this:
"   :.,+4!nl -ba -w1 -s' '

" People often use :r !prog to put the output of prog below the current line, which is fine for scripts, but when doing it
" on the fly, I find it easier to use !!ls instead, which replaces the current line.
"   :h filter
"   :h :read!

" Saner behavior of n and N
" If you want n to always search forward and N backward, use this:
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]

nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

" Go to other end of selected text
" o and O in a visual selection make the cursor go to the other end. Try with blockwise selection to see the difference.
"  This is useful for quickly changing the size of the selected text.
"   :h v_o
"   :h v_O

" Saner CTRL-L
" By default, <c-l> clears and redraws the screen (like :redraw!). The following mapping does the same, plus
"  de-highlighting the matches found via /, ? etc., plus fixing syntax highlighting (sometimes Vim loses highlighting due to
"  complex highlighting rules), plus force updating the syntax highlighting in diff mode:
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" ######################### command ##########################
" :global and :vglobal
" It's :g/re/p. Ken Thompson was inspired by vi's :global when he wrote grep.
" Despite its name, :global only acts on all lines by default, but it also takes a range. Assume you want use :delete
"  on all lines from the current line to the next blank line (matched by the regular expression ^$) that contain "foo":
"   :,/^$/g/foo/d
" For executing commands on all lines that do not match a given pattern, use :global! or its alias :vglobal (think inVerse) instead.

" :normal and :execute
" These commands are commonly used in Vim scripts.
" With :normal you can do normal mode mappings from the command-line. E.g. :normal! 4j will make the cursor go
"  down 4 lines (without using any custom mapping for "j" due to the "!").
" Mind that :normal also takes a range, so :%norm! Iabc would prepend "abc" to every line.
" With :execute you can mix commands with expressions. Assume you edit a C source file and want to switch to its header file:
"   :execute 'edit' fnamemodify(expand('%'), ':r') . '.h'
" Both commands are often used together. Assume you want to make the cursor go down "n" lines:
"   :let n = 4
"   :execute 'normal!' n . 'j'

" :redir and execute()
" Many commands print messages and :redir allows to redirect that output. You can redirect to files, registers or variables.
"   :redir => var
"   :reg
"   :redir END
"   :echo var
"   :" For fun let's also put it onto the current buffer.
"   :put =var
" In Vim 8 there is an even shorter way:
"   :put =execute('reg')
" Help:
"   :h :redir
"   :h execute()


" ######################### mapping ##########################
" save
nnoremap <leader>w :w<CR>
" exit vim
nnoremap <leader>q :q<CR>
" select all
nnoremap <Leader>sa ggVG"
" highlight last inserted text
nnoremap gV `[v`]

" align center {
    " zz >>> align center
    " search forward or backward and align center
    nnoremap <silent> n nzz
    nnoremap <silent> N Nzz
    " go to bottom and align center
    nnoremap <silent> G Gzz
    " search and align center
    nnoremap <silent> * *zz
    nnoremap <silent> g* g*zz
    nnoremap <silent> # #zz
    nnoremap <silent> g# g#zz
    " skip between bracket
    nnoremap <silent> % %zz
" }

" disable hightlight for search
noremap <silent><leader>/ :nohls<CR>
" Y key: yank from cursor to end of current line
map Y y$
" go to begin or end of curent line
nnoremap H ^
nnoremap L $

" command line {
    noremap ; :
    " command key binding is similar to terminal key binding
    cnoremap <C-j> <t_kd>
    cnoremap <C-k> <t_ku>
    cnoremap <C-a> <Home>
    cnoremap <C-e> <End>

    " Shortcuts
    " Change Working Directory to that of the current file
    cm cwd lcd %:p:h
    cm cd. lcd %:p:h

    " For when you forget to sudo.. Really Write the file.
    cm w!! w !sudo tee % >/dev/null

    " command-line window
    autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
" }


" display center after opening file
au BufReadPost * :normal! zz<cr>

" toggle {
    " F1 - F6 设置

    " F1 废弃这个键,防止调出系统帮助
    " I can type :help on my own, thanks.  Protect your fat fingers from the evils of <F1>
    noremap <F1> <Esc>"
    " F2 行号开关，用于鼠标复制代码用
    " 为方便复制，用<F2>开启/关闭行号显示:
    function! HideNumber()
      if(&relativenumber == &number)
        set relativenumber! number!
      elseif(&number)
        set number!
      else
        set relativenumber!
      endif
      set number?
    endfunc
    nnoremap <F2> :call HideNumber()<CR>
    " toggle number line
    "   nnoremap <F2> :set nu! nu?<CR>
    " F3 显示可打印字符开关
    " toggle tab symbol
    nnoremap <F3> :set list! list?<CR>
    " F4 换行开关
    " toggle wrap
    nnoremap <F4> :set wrap! wrap?<CR>
    " F6 语法开关，关闭语法可以加快大文件的展示
    nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

    set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
                                    "    paste mode, where you can paste mass data
                                    "    that won't be autoindented
" }

" screen/window {
    set splitright                      " Puts new vsplit windows to the right
    set splitbelow                      " Puts new split windows to the bottom

    " 分屏窗口移动, Smart way to move between windows
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l
    " c-j,k for buffer switch
    nm <c-j> :bn<cr>
    nm <c-k> :bp<cr>
    nm <tab> <c-w>w

    " resize screen
    map <up> :res +5<CR>
    map <down> :res -5<CR>
    map <left> :vertical resize-5<CR>
    map <right> :vertical resize+5<CR>ap <C-l> <C-W>l
" }

" http://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>

" Tab {
    " tab 操作
    " http://vim.wikia.com/wiki/Alternative_tab_navigation
    " http://stackoverflow.com/questions/2005214/switching-to-a-particular-tab-in-vim

    " tab mapping
    map tu :tabe<CR>
    map tn :-tabnext<CR>
    map ti :+tabnext<CR>

    " tab切换
    map <leader>th :tabfirst<cr>
    map <leader>tl :tablast<cr>

    map <leader>tj :tabnext<cr>
    map <leader>tk :tabprev<cr>
    map <leader>tn :tabnext<cr>
    map <leader>tp :tabprev<cr>

    map <leader>te :tabedit<cr>
    map <leader>td :tabclose<cr>
    map <leader>tm :tabm<cr>

    " 新建tab  Ctrl+t
    nnoremap <C-t>     :tabnew<CR>
    inoremap <C-t>     <Esc>:tabnew<CR>

    " Toggles between the active and last active tab "
    " The first tab is always 1 "
    let g:last_active_tab = 1
    " nnoremap <leader>gt :execute 'tabnext ' . g:last_active_tab<cr>
    " nnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
    " vnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
    nnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
    autocmd TabLeave * let g:last_active_tab = tabpagenr()

    " normal模式下切换到确切的tab
    noremap <leader>1 1gt
    noremap <leader>2 2gt
    noremap <leader>3 3gt
    noremap <leader>4 4gt
    noremap <leader>5 5gt
    noremap <leader>6 6gt
    noremap <leader>7 7gt
    noremap <leader>8 8gt
    noremap <leader>9 9gt
    noremap <leader>0 :tablast<cr>
" }

map sv <C-w>t<C-w>H
map sh <C-w>t<C-w>K

" Some helpers to edit mode
cm %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
nm <leader>ew :e %%
nm <leader>es :sp %%
nm <leader>ev :vsp %%
nm <leader>et :tabe %%

" 代码折叠自定义快捷键 <leader>zz
let g:FoldMethod = 0
map <leader>zz :call ToggleFold()<cr>
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfun

" 设置可以高亮的关键字
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
  endif
endif

"==========================================
" FileType Settings  文件类型设置
"==========================================

" 具体编辑文件类型的一般设置，比如不要 tab 等
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby,javascript,html,css,xml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown.mkd
autocmd BufRead,BufNewFile *.part set filetype=html
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai

" disable showmatch when use > in php
au BufWinEnter *.php set mps-=<:>

" 保存python文件时删除多余空格
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" 定义函数AutoSetFileHead，自动插入文件头
autocmd BufNewFile *.sh,*.py,*tcl exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    "如果文件类型为python
    if &filetype == 'python'
        " call setline(1, "\#!/usr/bin/env python")
        " call append(1, "\# encoding: utf-8")
        call setline(1, "\# -*- coding: utf-8 -*-")
    endif

    "如果文件类型为tcl
    if &filetype == 'tcl'
        call setline(1, "\#!/usr/bin/env wish")
    endif

    normal G
    normal o
    normal ^d$
    normal o
    normal ^d$
endfunc

" enable mode line and apply current file without reopen file
nnoremap <leader>ml :setlocal invmodeline <bar> doautocmd BufRead<cr>

" \rb                 一键去除全部尾部空白
imap <leader>rb <esc>:let _s=@/<bar>:%s/\s\+$//e<bar>:let @/=_s<bar>:nohl<cr>
nmap <leader>rb :let _s=@/<bar>:%s/\s\+$//e<bar>:let @/=_s<bar>:nohl<cr>
vmap <leader>rb <esc>:let _s=@/<bar>:%s/\s\+$//e<bar>:let @/=_s<bar>:nohl<cr>

" \ev                 编辑当前所使用的 Vim 配置文件
nmap <leader>emv <esc>:e $MYVIMRC<cr>
nmap <leader>smv <esc>:source $MYVIMRC<cr>

" ######################### gui ##########################
" 判断是否处于 GUI 界面
if has('gui_running')
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" 判断操作系统类型
if(has('win32') || has('win64'))
    let g:isWIN = 1
    let g:isMAC = 0
else
    if system('uname') =~ 'Darwin'
        let g:isWIN = 0
        let g:isMAC = 1
    else
        let g:isWIN = 0
        let g:isMAC = 0
    endif
endif

" 使用 GUI 界面时的设置
if g:isGUI
    " 启动时自动最大化窗口
    if g:isWIN
        au GUIEnter * simalt ~x
    endif
    "winpos 20 20              " 指定窗口出现的位置，坐标原点在屏幕左上角
    "set lines=20 columns=90   " 指定窗口大小，lines 为高度，columns 为宽度
    set guioptions+=c          " 使用字符提示框
    set guioptions-=m          " 隐藏菜单栏
    set guioptions-=T          " 隐藏工具栏
    set guioptions-=L          " 隐藏左侧滚动条
    set guioptions-=r          " 隐藏右侧滚动条
    set guioptions-=b          " 隐藏底部滚动条
    set showtabline=0          " 隐藏Tab栏
    set cursorline             " 高亮突出当前行
    " set cursorcolumn         " 高亮突出当前列
endif

" ######################### tip ##########################
" J                     >>> merge current line and next line to current line
" dip                   >>> remove near blank line
" q:                    >>> open cmd window in normal mode
" q/                    >>> open search window in normal mode
" <Ctrl-f>              >>> open cmd window in command mode
" <Ctrl-r><Ctrl-w>      >>> automatically completion for search when enable incsearch
" replace ack to grep
"   :set grepprg=ack\ --nogroup\ $*

" insert mode
" <Ctrl-h>              >>> remove previous character
" <Ctrl-w>              >>> remove previous word
" <Ctrl-u>              >>> remove cursor to begin of line
" <Ctrl-o>              >>> enter insert--normal mode
" <Ctrl-r>=             >>> temporarily calculate
" <Ctrl-r>{register}    >>> insert register

" mode line
" see corresponding modeline option
"   :verbose set modeline? modelines?
"
" vim:tabstop=4:shiftwidth=4:textwidth=100:expandtab
