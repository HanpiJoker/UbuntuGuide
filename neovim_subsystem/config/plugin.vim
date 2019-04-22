" 模板补全
" Update: 2019-04-22 14:41
" UltiSnips 的 tab 键与 YCM 冲突，重新设定
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"

" 库信息参考
" 启用:Man命令查看各类man信息
source $VIMRUNTIME/ftplugin/man.vim

" 定义:Man命令查看各类man信息的快捷键
nmap <Leader>man :Man 3 <cword><CR>


" 快捷键
map <SPACE> <Plug>(wildfire-fuel)
vmap <S-SPACE> <Plug>(wildfire-water)

" 适用于哪些结对符
let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "i>", "ip"]

" Nerdcommenter 配置
let g:NERDSpaceDelims=1

" auto-pairs 配置
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-b>'
let g:AutoPairsShortcutJump = '<M-n>'

" vim-autoformat
let g:formatdef_harttle = '"astyle --style=kr --pad-oper"'
let g:formatters_cpp = ['harttle']
let g:formatters_c = ['harttle']
let g:formatters_java = ['harttle']
" Multip Cursor 
" Default key mapping  
let g:multi_cursor_next_key='<C-n>'  
let g:multi_cursor_prev_key='<C-p>' 
let g:multi_cursor_skip_key='<C-x>'  
let g:multi_cursor_quit_key='<Esc>'
