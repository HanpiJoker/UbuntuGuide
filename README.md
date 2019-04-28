## Setup:
- 1. add folder "vim", folder "tags", file "vimrc", file "ycm_extra_conf.py" in your home directory(cd ~)
- 2. modify the name "vim", "tags", "vimrc", "ycm_extra_conf.py" to ".vim", "tags",.vimrc", ".ycm_extra_conf.py"

Then everything is done.

## Notes:
folder "tags" is used to set C/C++ autocompleting(for standard C++ library and Linux API), it contains "stdcpp.tags" and "sys.tags", if it doesn't work well in your system,
then you can do as follows to create your own "tags".

- 1) cd /usr/include/c++/4.9 (different systems may have different c++ version,so you should use your own version,such as 4.8)
- 2) ctags -R --c++-kinds=+l+x+p --fields=+iaSl --extra=+q --language-force=c++ -f stdcpp.tags
- 3) use stdcpp.tags to replace the one in folder "tags"
- 4) if the C++ version in your system in not 4.9, then you need to update the ".ycm_extra_conf.py",replace the line 59 with your own version.

- 5) cd /usr/include/
- 6) ctags -R --c-kinds=+l+x+p --fields=+lS -I __THROW,__nonnull -f sys.tags
- 7) use sys.tags to replace the one in folder "tags"

## coc.vim Install

> 除了coc以外还有ncm2这个补全插件，不过由于ncm2不需要特别的依赖和配置。所以不记录ncm2的安装过程了。

#### coc.vim 安装流程

1. 安装Nodejs和yarn

```shell
# Install NodeJs
curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh

sudo bash nodesource_setup.sh

sudo apt install nodejs
# 至于Yarn的安装流程在安装完NodeJs之后会提示的，这里做一个备份
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update && sudo apt-get install yarn
```

2. 安装coc.vim

```shell
# First Add coc.vim in nvim's setting file(init.vim)
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
# checkout service state, make sure coc install successfully
# start nvim and type
:checkhealth # type in nvim normal mode
# if service init error, We can type the following command 
# in nvim
:call coc#util#build()  # type in nvim normal mode

# Now the coc is installed successfully
```

3. 安装coc  的 C/C++ 支持

> First We should install ccls, which is a C/C++/Objective-C  language server can help us complete c/c++ code

Install CCLs First

```shell
# We need download "Pre-Built Binaries" from https://releases.llvm.org/download.html
# and unpack to /path/to/clang+llvm-xxx
git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cd ccls
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/path/to/clang+llvm-xxx

cmake --build Release
cmake --build Release --target install

```

Setting  ccls for coc.vim

```shell
# We need register custom language servers in coc.vim
# First open cocconfig.json 
:CocConfig  # type in nvim normal mode
# Input setting
{
    "languageserver": {
    "ccls": {
      "command": "ccls",
      "filetypes": ["c", "cpp", "objc", "objcpp"],
      "rootPatterns": [".ccls", "compile_commands.json", ".vim/", ".git/", ".hg/"],
      "initializationOptions": {
         "cache": {
           "directory": "/tmp/ccls"
         }
       }
    }
  }  
}
```

4.  Install Other Plugins

```shell
# In coc.vim, we can Install some extensions by using CocInstall
:CocInstall <coc-plugins> # type in nvim normal mode

# Plugin Lists (recommend install)
coc-json 
coc-snippets
coc-highlight
coc-dictionary
coc-tag
coc-ultisnips
```

