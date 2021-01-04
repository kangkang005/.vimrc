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

" cursor option
set cursorcolumn
set cursorline
" indent option
set tabstop=4       " insert mode tab use 4 spaces
set shiftwidth=4    " indent 4 spaces when using >> or <<
set softtabstop=4   " insert mode tab and backspace use 4 spaces "
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

" <leader> is whitespace
let mapleader = " "
" change region around brackets
onoremap in) :<c-u>normal! f)vi)<cr>
onoremap in( :<c-u>normal! f(vi(<cr>

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
map <Leader>sa ggVG"
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
" disable hightlight for search
noremap <silent><leader>/ :nohls<CR>
" yank from cursor to end of current line
map Y y$
noremap ; :
" move cursor to begin or end of curent line
nnoremap H ^
nnoremap L $
" command key binding is similar to terminal key binding
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" display center after opening file
au BufReadPost * :normal! zz<cr>

" toggle number line
nnoremap <F2> :set nu! nu?<CR>
" toggle tab symbol
nnoremap <F3> :set list! list?<CR>
" toggle wrap
nnoremap <F4> :set wrap! wrap?<CR>

" transfer screen
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" enable mode line and apply current file without reopen file
nnoremap <leader>ml :setlocal invmodeline <bar> doautocmd BufRead<cr>

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
" vim:tabstop=4:shiftwidth=4:textwidth=100
