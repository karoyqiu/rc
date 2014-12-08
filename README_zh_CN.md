# rc

这个项目是我每天在 Fedora 下进行 C++ 开发的配置文件集合，这些配置文件针对使用 CMake 源代码外编译的 C/C++ 项目进行特殊优化。这些配置文件包括：

* [Zsh](http://www.zsh.org/)：我自己的 [oh-my-zsh](https://github.com/karoyqiu/oh-my-zsh)，fork 自 http://ohmyz.sh/ 。
* VIM：基于 [amix/vimrc](https://github.com/amix/vimrc) 的 [Basic 版本](https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim)修改而来，为 C++ 编程进行了优化。
* [AStyle](http://astyle.sourceforge.net/)：符合本人编程风格的 astylerc，适用于 2.04 或更高版本。
* Git：全局 gitconfig 和 gitignore 文件。
* 其它：为 ccache 添加 clang 编译器适配脚本。

## 安装

因为这个项目里面有一些我个人信息（比如用户名和邮箱），所以**推荐在安装前先 fork 一个自己的版本**，并修改用户名和邮箱。需要修改的地方后面会提到。
直接执行 `install.sh` 即可，不过这个脚本从来没测试过……

## Zsh

Zsh 配合 oh-my-zsh 确实很好用，忽略大小写的补全，命令行参数提示，Git 版本控制状态显示，主题，等等等等。rc 中的 oh-my-zsh 是我 fork 的版本，会不定时的合并上游修改。我的版本在原版本的基础上主要进行了以下修改：

* 将 Git 版本状态符号从 o/x 换成 ✔/✘，不过这两个字符在 ssh 登录下显示有问题。
* 添加了 CMake 相关的命令行别名：
  * `cmake`：默认编译 Debug 版本，并导出编译命令。
  * `clang-cmake`：将编译器设置为 clang/clang++。
  * `ninja-cmake`：使用 [ninja](http://martine.github.io/ninja/) 进行构建，而不是 make。
  * `nc-cmake`：包含上面两项。
* 修改默认主题为 ys，启用 git、git-flow、autojump 和 sudo 插件。

安装方法参见 http://ohmyz.sh/ 。

## VIM

VIM 的配置向来都是一个比较麻烦的事情，一千个程序员有一千个 vimrc。几年前在 Google 中搜到了 [amix/vimrc](https://github.com/amix/vimrc)，直接就把 Awesome 版本拿来用了。但里面插件实在太多了，由于 个人习惯问题，有很多平时根本用不到，还把 VIM 拖得很慢。所以我以其 Basic 版本为蓝本重新配置了 VIM，只作了些小修改，添加了几个常用的插件。本 vimrc 专门针对同时满足以下条件的使用场景进行优化：

* 项目代码使用 C/C++ 语言编写；
* 项目使用 [CMake](http://www.cmake.org/) + make/ninja + gcc/g++/clang/clang++ 构建；
* 在项目顶层目录下的 build 目录中进行源代码外构建；
* 使用上面的 `cmake` 命令行别名执行 cmake，或在执行 cmake 时指定 `-DCMAKE_EXPORT_COMPILE_COMMANDS=1`。
* 将 `vimrc/ycm_extra_conf.py` 复制到项目顶层目录下，并重命名为 `.ycm_extra_conf.py`。

如果满足以上条件，则可以达到以下效果：

* **C/C++ 代码提示及补全**
  几乎没有延迟的、基于整个项目源代码分析的代码补全，代码片段补全，以及文件系统补全等等。虽然赶不上 Visual Assist 好用，但已经差不多了。在输入`.`、`->`或`::`时会自动弹出补全列表，`Ctrl+N`/`Ctrl+P` 在备选项间选择，`Tab` 补全。如果要在任意时间补全，按 `Ctrl+空格`。
* **一键编译**
  无论正在编译的文件在项目中的什么位置，按 `F7` 自动在项目顶层目录下的 build 的目录中执行 `make` 或 `ninja`。编译完成后自动定位至编译错误代码，`,n` 和 `,p` 在各编译错误间跳转。

### 安装

备份并删除原有的 $HOME/.vimrc 和 $HOME/.vim，然后在 $HOME 下建立一个名为 .vim 的指向 rc/vimrc 的软链接即可。不需要再建立 $HOME/.vimrc 文件，这个文件不存在时 VIM 会读取第二用户配置文件 $HOME/.vim/vimrc（至少在 Fedora 下是这样）。

```
mv ~/.vimrc ~/.vimrc.bak
mv ~/.vim ~/.vim.bak
ln -s /path/to/where-you-clone-rc/vimrc ~/.vim
```

### 包含的插件

vimrc 包含以下插件，建议在使用过程中阅读这些插件自己的文档。

* [vundle](https://github.com/gmarik/Vundle.vim)：插件管理器。
* [YouCompleteMe](https://valloric.github.io/YouCompleteMe/)：最好用的 VIM 实时补全插件，没有之一。
* [UltiSnips](https://github.com/SirVer/ultisnips)：代码片段插件，本身不包含任何代码片段，与 YCM 配合使用。
* [vim-snippets](https://github.com/honza/vim-snippets)：代码片段库，供 UltiSnips 使用。
* [vim-airline](https://github.com/bling/vim-airline)：状态栏插件。
* [DoxygenToolkit.vim](https://github.com/karoyqiu/DoxygenToolkit.vim)：[Doxygen](https://www.doxygen.org/) 风格代码注释插件，fork 自 [vim-scripts/DoxygenToolkit.vim](https://github.com/vim-scripts/DoxygenToolkit.vim)，将前导字符换成了“\”。
* [vim-template](https://github.com/karoyqiu/vim-template)：文件模板插件，fork 自 [aperezdc/vim-template](https://github.com/aperezdc/vim-template)，将 C/C++ 文件模板换成 Doxygen 风格的文件头。
* [a.vim](https://github.com/vim-scripts/a.vim)：在相关文件间切换插件（比如在 .h 和 .cpp 文件之间切换）。
* [taglist.vim](https://github.com/vim-scripts/taglist.vim)：符号列表插件。

vimrc 中其它插件是上面插件的依赖插件。

### 键盘映射

设置 map leader 为逗号键（`,`）：

    let mapleader = ","
    let g:mapleader = ","

`,w` 快速保存：

    nmap <leader>w :w!<cr>

在使用 `j`/`k` 移动光标时将长行视为断行：

    map j gj
    map k gk

将空格键映射为搜索：

    map <space> /

`,回车` 禁用查找高亮：

    map <silent> <leader><cr> :noh<cr>

可视模式下使用 `*`/`#` 键在当前选择内查找：

    vnoremap <silent> * :call VisualSelection('f', '')<CR>
    vnoremap <silent> # :call VisualSelection('b', '')<CR>

使用 `Ctrl+j/k/h/l` 在窗口间移动：

    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l

标签页相关的映射：

    map <leader>tn :tabnew<cr>
    map <leader>to :tabonly<cr>
    map <leader>tc :tabclose<cr>
    map <leader>tm :tabmove
    map <leader>t<leader> :tabnext

`,te` 以当前缓冲区路径打开新标签页，在编辑相同目录下的文件时非常有用：

    map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

将 `0` 重新映射为移动到第一个非空白字符：

    map 0 ^

出错窗口相关映射：

    map <leader>cc :botright cope<cr>
    map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
    map <leader>n :cn<cr>
    map <leader>p :cp<cr>

`,m` 删除 Windows 下的 ^M：

    noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

`,pp`切换粘贴模式：

    map <leader>pp :setlocal paste!<cr>

下面是我的设置。

C/C++ 文件类型下 `F7` 执行构建：

    autocmd FileType c,cpp nnoremap <F7> :make<CR><CR>

`Alt+O` 在新标签页打开相关文件（即在 .h 和 .cpp 文件间切换）：

    nnoremap <silent> <A-o> :AT<CR>

`Alt+G` 跳转至声明或定义：

    nnoremap <silent> <A-g> :YcmCompleter GoTo<CR>

`F11` 打开/关闭当前文件符号列表：

    nnoremap <silent> <F11> :TlistToggle<CR>

`F12` 使用 Doxygen 风格对当前函数、方法或类进行注释：

    nnoremap <silent> <F12> :Dox<CR>

上面 Alt 键相关的配置在 vimrc 中看起来并不是上面那样，因为 Alt 键在终端模拟器中有特殊处理。vimrc 中的配置在 GNOME Terminal 下可用。

### 个人信息

vimrc 最后为 vim-template 配置了用户名和邮箱，可根据需要进行修改：

    let g:username = "Roy QIU"
    let g:email = "karoyqiu@gmail.com"

## Git

gitconfig 中设置了用户名和邮箱，可根据需要进行修改。
另外，添加了命令别名，不过在 Zsh 下似乎都用不到：

    br = branch
	co = checkout
	st = status

## 其它

### Artistic Style

符合个人习惯的配置文件，具体内容可对比 AStyle 文档进行确认。

### clang 和 ccache

直接在 ccache 中使用 clang 会有一些问题（自己试一下就知道了），直到后来在墙外面找到了这两个脚本：[这里](http://petereisentraut.blogspot.com/2011/05/ccache-and-clang.html)和[这里](http://petereisentraut.blogspot.com/2011/09/ccache-and-clang-part-2.html)。Fedora 下直接将这两个脚本复制到 /usr/lib/ccache 下即可。

    sudo cp scripts/clang* /usr/lib/ccache/
