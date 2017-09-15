# Ubuntu 安装指南

## 前言
  玩Ubuntu已经有一年时间了，期间也多次重装系统。因为自己主要做C语言开发，  
并且很羡慕那些用vim进行开发的。所以我也花了很久来配置自己的vim。这次电脑  
不知道什么故障打不开了，无奈只能重装系统。最后，我决定记录下来配置的每一步  
为以后提供一个文本。

## 1. 基础配置（一些基础软件的配置和安装）

### 浏览器， 音乐播放器

浏览器我选择的是 **chrome**，这个的安装还是很方便的。官网直接下载就好了。音乐播放器  
是 **网易云音乐**， 依旧在官网上下载对应deb包就好了。

### 问题1： kde 默认终端konsole的字体基线无法对齐

解决方案：从网上下载一个包含中文和英文的字体， 我选的是YaHei Consolas Hybird。  
下载安装。安装方法： 将字体的ttf文件移至/usr/share/fonts目录下，修改字体文件的权限  
为 664。 然后移动至/usr/share/fonts， 然后执行:
    sudo mkfontscale && sudo mkfontdir && sudo fc-cache -fv
至于命令的具体含义可以百度，时间长了，我也给忘记了。

### 问题2：安装deb包的时候出现了Unknown media type in type 'all/all'

首先备份一下 /usr/share/mime/packages/kde.xml，然后打开kde.xml， 将里面  
 < mime-type type="all/all" > to < /mime-type >格式的语句全部删除。 

    <mime-type type="all/all">  
    <comment>all files and folders</comment>  
    </mime-type>  
    <mime-type type="all/allfiles">  
    <comment>all files</comment>  
    </mime-type>  

### 问题3： Ubuntu 报错：”对不起，Ubuntu 16.04出现了内部错误。”

解决方案：碰到此类错误提示，可选择不管，为正常现象，每个Ubuntu版本都会碰到。
sudo apt-get remove apport处理即可。

### uget aria2 安装配置

命令：
    sudo add-apt-repository ppa:plushuang-tw/uget-stable 
    sudo apt-get update 
    sudo apt-get install uget aria2

设置：
    打开uget→编辑→设置
    修改aria2 参数为：
        --enable-rpc=true

### java8的安装

Ubuntu自带的有开源的jdk，如果对java没有特殊需求可以省略这一步
>安装步骤：
>>sudo apt-get install python-software-properties
>>sudo add-apt-repository ppa:webupd8team/java
>>sudo apt-get update 
>>sudo apt-get install oracle-java8-installer


## 2. 美化kde时候的一些问题

### 1. sddm登录界面的配置文件夹
/usr/share/sddm

### 2. kde欢迎界面的配置文件夹
/usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents

## 3. vim 的编译安装和插件安装

### 编译安装vim8.0
从vim官网下载vim8.0的源码包解压:  

    tar -xjvf vim-8.0.tar.bz2
    cd ~/path to vim80/vim80

设置vim源码的编译属性：

    ./configure --with-features=huge --enable-rubyinterp  --enable-pythoninterp 
    --with-python-config-dir=/usr/lib/python2.7/config-i386-linux-gnu/ 
    --enable-perlinterp --enable-gui=gtk2 --enable-cscope 
    --enable-luainterp --enable-perlinterp --enable-multibyte --prefix=/usr

需要重新配置可 输入 make distclean #清理一下上一次编译生成的所有文件

其中参数说明如下：

- --with-features=huge：支持最大特性
- --enable-rubyinterp：启用Vim对ruby编写的插件的支持
- --enable-pythoninterp：启用Vim对python编写的插件的支持
- --enable-luainterp：启用Vim对lua编写的插件的支持
- --enable-perlinterp：启用Vim对perl编写的插件的支持
- --enable-multibyte：多字节支持 可以在Vim中输入中文
- --enable-cscope：Vim对cscope支持
- --enable-gui=gtk2：gtk2支持,也可以使用gnome，表示生成gvim
- --with-python-config-dir=/usr/lib/python2.7/config-i386-linux-gnu/ 指定 python 路径
- --prefix=/usr：编译安装路径

然后编译安装：

    sudo make VIMRUNTIMEDIR=/usr/share/vim/vim80
    sudo make install

### vim的插件安装
这个github上有一篇相当不错切成熟的配置：[像IDE 一样使用vim - GitHub](https://github.com/yangyangwithgnu/use_vim_as_ide)  
大部分配置都可以安装这个教程进行。

### ycm的编译安装
ycm插件应该是vim所有插件最难搞定的，至少我目前接触的里面是最难搞的。  
在网上找了很多教程，反反复复还是觉得这个教程是最有效也是最简单的：  
[一步一步带你安装史上最难安装的 vim 插件 —— YouCompleteMe](http://www.jianshu.com/p/d908ce81017a)  

不过细节上我还有几点补充：

1. 目测不用试第一种最简单的方法了，因为基本不可能成功。(反正我是没成功过的)
2. 编译安装ycm之前，如果需要C家族的语义补全的话，之前先在[llvm+clang官网](https://llvm.org/)  

#### ycm的配置


>    " YCM 补全
>
>    " YCM 补全菜单配色
>    " 菜单
>    highlight Pmenu ctermfg=4 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
>    " 选中项
>    highlight PmenuSel ctermfg=1 ctermbg=4 guifg=#AFD700 guibg=#106900
>
>    " 补全功能在注释中同样有效
>    let g:ycm_complete_in_comments=1
>
>    " 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
>    let g:ycm_confirm_extra_conf=0
>
>    " 开启 YCM 标签补全引擎
>    let g:ycm_collect_identifiers_from_tags_files=0
>    "" 引入 C++ 标准库 tags
>    "set tags+=/data/misc/software/app/vim/stdcpp.tags
>    "set tags+=/data/misc/software/app/vim/sys.tags
>
>    " YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
>    inoremap <leader>; <C-x><C-o>
>
>    " 补全内容不以分割子窗口形式出现，只显示补全列表
>    set completeopt-=preview
>
>    " 从第一个键入字符就开始罗列匹配项
>    let g:ycm_min_num_of_chars_for_completion=1
>
>    " 禁止缓存匹配项，每次都重新生成匹配项
>    let g:ycm_cache_omnifunc=0
>
>    " 语法关键字补全
>    let g:ycm_seed_identifiers_with_syntax=1
>
>    let g:ycm_server_python_interpreter='/usr/bin/python'
>    let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
>
>    "离开插入模式后自动关闭预览窗口"
>    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
>
>    "补全后自动关机预览窗口"
>    let g:ycm_autoclose_preview_window_after_completion=1
>
>    "是否在注释中也开启补全"
>    let g:ycm_complete_in_comments=1
>    let g:ycm_collect_identifiers_from_comments_and_strings = 1

这个是我的ycm的配置，大部分是来源于 **use_as_ide**里的vimrc。还有一部分  
是从网上其他地方找到的。

### cscope的配置
因为ctags的配置在[像IDE 一样使用vim - GitHub](https://github.com/yangyangwithgnu/use_vim_as_ide) 里
已经讲的很明白了，所以我这里也就省略了。至于ctags和cscope的用法，在以后的vim相关命令操作里再总结。

> if has("cscope")
>     set csprg=/usr/bin/cscope
>     set csto=0
>     set cst
>     set nocsverb
>     " add  any  database  in  current  directory
>     if filereadable("cscope.out")
>         cs add cscope.out
>     "else add database pointed to by environment
>     elseif $CSCOPE_DB != ""
>         cs add $CSCOPE_DB
>     endif
>     set csverb
> endif
> 
> nmap <C-a>s :scs find s <C-R>=expand("<cword>")<CR><CR>
> nmap <C-a>g :scs find g <C-R>=expand("<cword>")<CR><CR>
> nmap <C-a>c :scs find c <C-R>=expand("<cword>")<CR><CR>
> nmap <C-a>t :scs find t <C-R>=expand("<cword>")<CR><CR>
> nmap <C-a>e :scs find e <C-R>=expand("<cword>")<CR><CR>
> nmap <C-a>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
> nmap <C-a>i :scs find i <C-R>=expand("<cfile>")<CR><CR>
> nmap <C-a>d :scs find d <C-R>=expand("<cword>")<CR><CR>
依旧是把我的配置放上来，这个没什么好纠结，就是映射了一些快捷键  
然后写了个脚本使得vim打开之后自动载入cscope.out。


### Markdown 相关插件下载
为了能通过vim更好的编写Markdown，我们需要一些插件。来让vim对markdown更友好  
这个部分可以参考[Vim与Markdown，实现键不离手](http://www.jianshu.com/p/fa8c56e1aa52)和
[vim安装markdown插件](http://www.jianshu.com/p/24aefcd4ca93)
不过他还有几点不足：
1. 首先是那个实时预览插件: vim-instant-markdown, python-instant-markdown。并不怎么好用
   不过好在[vim安装markdown插件](http://www.jianshu.com/p/24aefcd4ca93)在一次更新推荐了
   [markdown-preview.vim](https://github.com/iamcco/markdown-preview.vim), 这个还是很不错的

2. Markdown的大纲功能实现有很多解决方案，我最喜欢的是[markdown2ctags.py](http://blog.csdn.net/demorngel/article/details/70055789)  
   可以参考这个网址进行配置

### 其他一些插件的配置和使用

#### easymotion 快速跳转

> let g:EasyMotion_smartcase = 1
> "let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
> map <Leader><leader>h <Plug>(easymotion-linebackward)
> map <Leader><Leader>j <Plug>(easymotion-j)
> map <Leader><Leader>k <Plug>(easymotion-k)
> map <Leader><leader>l <Plug>(easymotion-lineforward)
> " 重复上一次操作, 类似repeat插件, 很强大
> map <Leader><leader>. <Plug>(easymotion-repeat)

#### delimitmate 符号自动补全(被动技能)

> " for python docstring ", 特别有用
> au FileType python let b:delimitMate_nesting_quotes = ['"']
> " 关闭某些类型文件的自动补全
> "au FileType mail let b:delimitMate_autoclose = 0

#### ctrlsf 全局搜索

> " 设置ctrlsf
> let g:ctrlsf_ackprg = 'ag'   

说明: 这个搜索插件需要下载ag/ack，我下的是ag
网址是：[Ag](https://geoff.greer.fm/ag/)

> tar -zxvf the_silver_searcher-2.1.0.tar.gz  (这是我现在的最新版 2017年9月15日)
> ./configure 
> make 
> sudo make install 即安装ag 

## 结语
  直到目前我的配置工作已经初步完成，剩下的VMware， Qt的安装，还有交叉编译器都是相当简单的。  
这里就不在赘述了。
