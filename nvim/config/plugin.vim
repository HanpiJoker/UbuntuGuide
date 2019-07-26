" 模板补全
" UltiSnips 的 tab 键与 YCM 冲突，重新设定
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"

" 库信息参考
" 启用:Man命令查看各类man信息
source $VIMRUNTIME/ftplugin/man.vim

" 定义:Man命令查看各类man信息的快捷键
nmap <Leader>man :Man 3 <C-R>=expand("<cword>")<CR><CR>


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

" NerdTree Setting
nmap <leader>fl :NERDTreeToggle<CR>
let NERDTreeWindSize=10
let NERDTreeWinPos="right"
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1

"Air Line Setting
let g:airline_theme='violet'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_step = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts=1

"Tagbar
" 设置 tagbar 子窗口的位置出现在主编辑区的左边 
let tagbar_left=1 
" 设置显示／隐藏标签列表子窗口的快捷键。速记：identifier list by tag
nnoremap <Leader>ilt :TagbarToggle<CR> 
" 设置标签子窗口的宽度 
let tagbar_width=20
" tagbar 子窗口中不显示冗余帮助信息 
let g:tagbar_compact=1

" Source Explorer
" // The switch of the Source Explorer 
nnoremap <Leader>sre :SrcExplToggle<CR> 

" // Set the height of Source Explorer window 
let g:SrcExpl_winHeight = 8 

" // Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 1000

" // Set "Enter" key to jump into the exact definition context 
let g:SrcExpl_jumpKey = "<ENTER>" 

" // Set "Space" key for back from the definition context 
let g:SrcExpl_gobackKey = "<SPACE>" 

" // In order to avoid conflicts, the Source Explorer should know what plugins except
" // itself are using buffers. And you need add their buffer names into below list
" // according to the command ":buffers!"
let g:SrcExpl_pluginList = [
        \ "__Tag_Bar__",
        \ "_NERD_tree_",
        \ "Source_Explorer"
    \ ]

" // The color schemes used by Source Explorer. There are five color schemes
" // supported for now - Red, Cyan, Green, Yellow and Magenta. Source Explorer
" // will pick up one of them randomly when initialization.
let g:SrcExpl_colorSchemeList = [        
        \ "Red",
        \ "Cyan",
        \ "Green",
        \ "Yellow",
        \ "Magenta"
    \ ]

" // Enable/Disable the local definition searching, and note that this is not 
" // guaranteed to work, the Source Explorer doesn't check the syntax for now. 
" // It only searches for a match with the keyword according to command 'gd' 
let g:SrcExpl_searchLocalDef = 1 

" // Workaround for Vim bug @https://goo.gl/TLPK4K as any plugins using autocmd for
" // BufReadPre might have conflicts with Source Explorer. e.g. YCM, Syntastic etc.
let g:SrcExpl_nestedAutoCmd = 1

" // Do not let the Source Explorer update the tags file when opening 
let g:SrcExpl_isUpdateTags = 0

" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
" // create/update the tags file 
" let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." 

" // Set "<F12>" key for updating the tags file artificially 
" let g:SrcExpl_updateTagsKey = "<S-c>" 

" // Set "<S-k>" key for displaying the previous definition in the jump list 
let g:SrcExpl_prevDefKey = "<S-k>" 

" // Set "<S-k>" key for displaying the next definition in the jump list 
let g:SrcExpl_nextDefKey = "<S-j>" 
function! OpenProgramPlugin ()
    UndotreeHide
    SrcExplToggle
    TagbarToggle
    NERDTreeToggle
endfunction
nnoremap <leader>cla :call OpenProgramPlugin()<CR>

" Ctrl P Setting
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
map <leader>cp :CtrlP<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

" Ale Error Check
"始终开启标志列
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
" Clang for C & C++
let g:ale_linters = {
\   'c++': ['clang'],
\   'c': ['clang'],
\}
" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

" === MarkdownPreview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'chromium'
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

" === Vim Table Mode
" <Leader>tdd 删除一行
" <Leader>tdc 删除一列
nnoremap <leader>tm :TableModeToggle<CR>
" === Vim MarkDown
"let g:markdown_enable_conceal = ""
let g:markdown_quote_syntax_on_filetypes = ['text']
set conceallevel=2
" === UndoTree
function! OpenUndoTree()
    SrcExplClose
    TagbarClose
    NERDTreeClose
    UndotreeToggle 
endfunction
nnoremap <leader>ud :call OpenUndoTree()<CR>
let g:undotree_WindowLayout = 2
set undodir=~/.undodir/
set undofile

" === Goyo
nnoremap <leader>go :Goyo<CR>

" === vim-translate-me
" <Leader>t 翻译光标下的文本，在命令行回显
nmap <silent> <Leader>te <Plug>Translate
vmap <silent> <Leader>te <Plug>TranslateV
" Leader>w 翻译光标下的文本，在窗口中显示
nmap <silent> <Leader>we <Plug>TranslateW
vmap <silent> <Leader>we <Plug>TranslateWV
" Leader>r 替换光标下的文本为翻译内容
nmap <silent> <Leader>re <Plug>TranslateR
vmap <silent> <Leader>re <Plug>TranslateRV

" 设置ctrlsf
let g:ctrlsf_ackprg = 'ag'   
nmap <Leader>sf :CtrlSF<space>

nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> <C-j> <Plug>(coc-references)
nn <silent> K :call CocActionAsync('doHover')<cr>

