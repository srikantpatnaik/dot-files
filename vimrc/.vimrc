" Srikant Patnaik's VIM configuration.

syntax on


"Auto remove trailing whitelines
autocmd BufWritePre * :%s/\s\+$//e
ret


"set number
set tabstop=4
"set colorcolumn=80
set textwidth=80


" Use 'z=' to get suggestions on spellings
set spell
"set nospell


"macro added to make pdf from rst on feb21st 2013
"map <buffer> <F4> :<Esc>:w<CR>:!clear<CR>:!rst2pdf % -o .tmp.pdf<CR>:!evince .tmp.pdf 2>/dev/null &<CR>: <Ins> <CR>
"map <buffer> <F3> :<Esc>:w<CR>:!clear<CR>:!bash %<CR>
"map <buffer> <F3> :<Esc>:w<CR>:!clear<CR>:!python %<CR>


"macro for arduino using inotool and serial monitor
"map <buffer> <F4> :<Esc>:w<CR>:!clear<CR>:!ino build<CR>:!ino upload<CR>:!ino serial<CR>: <Ins> <CR>
"arduino with intool without serial monitor
"map <buffer> <F3> :<Esc>:w<CR>:!clear<CR>:!ino build<CR>:!ino upload<CR>: <Ins> <CR>


"macro to insert rst external hyperlink


"TableModeToggle #creates table in VIM  https://github.com/dhruvasagar/vim-table-mode/
let g:table_mode_corner_corner="+"
let g:table_mode_header_fillchar="="


"Solarized color theme https://github.com/altercation/vim-colors-solarized
syntax enable
set background=dark
colorscheme solarized
let g:solarized_termcolors=256
set term=screen-256color


"For mutt (I guess?)
"autocmd BufRead /tmp/user/1000/mutt-* execute "normal /^$/\n"
"autocmd BufRead /tmp/user/1000/mutt-* execute ":startinsert"
autocmd FileType mail set spell


"For LanguageTool (Grammer checker)
let g:languagetool_jar='/opt/LanguageTool-3.1/languagetool-commandline.jar'


