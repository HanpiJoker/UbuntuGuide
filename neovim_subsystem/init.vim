" 更新时间: 2019-1-25

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'

" Can be changed by COC for coc.vim; NCM2 for ncm2; YCM for YouCompleteMe
let complete = "COC" 

" 插件安装
call plug#begin('~/.config/nvim/plugged')
" C++语法高亮
Plug 'octol/vim-cpp-enhanced-highlight'
" 多光标
Plug 'terryma/vim-multiple-cursors'
" 智能注释
Plug 'scrooloose/nerdcommenter'
" 代码块补全
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" 代码补全
if complete == "NCM2"
    Plug 'ncm2/ncm2'    
    Plug 'roxma/nvim-yarp'      
    Plug 'ncm2/ncm2-bufword'     
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-syntax' 
    Plug 'Shougo/neco-syntax'
    Plug 'ncm2/ncm2-pyclang'
    Plug 'ncm2/ncm2-ultisnips'
    Plug 'ncm2/ncm2-jedi'
    Plug 'ncm2/ncm2-vim' 
    Plug 'Shougo/neco-vim'
    " Plug 'ncm2/float-preview.nvim'
elseif complete == "YCM"
    Plug 'Valloric/YouCompleteMe'
elseif complete == "COC"
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
endif
Plug 'easymotion/vim-easymotion'
" 快速选择结对符内文本
Plug 'gcmt/wildfire.vim'
" 为指定文本加括号
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
" 自动格式化代码
Plug 'Chiel92/vim-autoformat'
" 插件列表结束
call plug#end()

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/plugin.vim'

if complete == "NCM2"
    set shortmess+=c      
    inoremap <c-c> <ESC>
    inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

    "  Use <TAB> to select the popup menu:     
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"     
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"      

    " path to directory where libclang.so can be found
    let g:ncm2_pyclang#library_path = '/usr/lib/llvm-6.0/lib'

    autocmd BufEnter * call ncm2#enable_for_buffer()

elseif complete == "YCM"
    if filereadable(fnamemodify(expand('<sfile>'), ':h').'/config/ycm.vim')
        execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/ycm.vim'
    endif
elseif complete == "COC"
    if filereadable(fnamemodify(expand('<sfile>'), ':h').'/config/coc.vim')
        execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/coc.vim'
    endif
endif
unlet! complete

