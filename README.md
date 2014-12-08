# rc

简体中文用户可以来[这里](https://github.com/karoyqiu/rc/blob/master/README_zh_CN.md)。

This is a collection of config files of my everyday C++ programming on Fedora. These config files are specially optimized for building C++ project with [CMake](http://www.cmake.org/). It includes:

* [Zsh](http://www.zsh.org/): My own [oh-my-zsh](https://github.com/karoyqiu/oh-my-zsh)，forked from http://ohmyz.sh/ .
* VIM: Based on the [Basic](https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim) version of [amix/vimrc](https://github.com/amix/vimrc).
* [AStyle](http://astyle.sourceforge.net/): An astylerc file for AStyle 2.04 or higher.
* Git: Global gitconfig and gitignore file.
* Others: Two scripts for clang building with ccache.

## Installation

These config files contain some my personal information such as username and email. Because of this, **it is recommended that fork this repository and change the personal information before installing.**
You can run the *never-tested* installation script `install.sh` to install.

## Zsh

Oh-my-zsh makes Zsh quite good to use. I forked it and made some changes:

* Changed the status sign of Git from `o/x` to `✔/✘`. But these two characters cannot be displayed well under SSH.
* Added some alias related to CMake:
  * `cmake`: Compile the debug configuration, and export the build command.
  * `clang-cmake`: Build with clang/clang++ instead of gcc/g++.
  * `ninja-cmake`: Build with [ninja](http://martine.github.io/ninja/) instead of make.
  * `nc-cmake`: The combination of `ninja-cmake` and `clang-cmake`.
* Changed the default theme to ys，and enabled these plugins: git, git-flow, autojump and sudo.

See http://ohmyz.sh/ for more information.

## VIM

VIM is a little bit hard to configure. There are a thousand vimrcs for a thousand programmers. I've googled [amix/vimrc](https://github.com/amix/vimrc) several years ago, and used the Awesome version without any thought. There are a lot plugins making VIM slow, and most of them are not used in my everyday C++ programming. So, I make my own version of vimrc based on its Basic version by adding a few nice plugins. It's specially optimized for the editing-building of the projects that meet all of the conditions below:

* The project is written in C/C++.
* The project is built with CMake + make/ninja + gcc/g++/clang/clang++.
* The project is built in the `build` directory under its top directory.
* The project is 'cmaked' by the `cmake` alias above, or with `-DCMAKE_EXPORT_COMPILE_COMMANDS=1`.
* Copy `vimrc/ycm_extra_conf.py` to the top directory of the project and rename it to `.ycm_extra_conf.py`.

If so, the VIM can:

* **C/C++ code completion**

Code, snippet and filesystem completion based on the source code of the project. The completion list will popup almost instantly after inputting `.`, `->` or `::`. Press `Ctrl+N`/`Ctrl+P` to move around the list, and press `Tab` to complete. To complete code at any time, press `Ctrl+Space`.

* **Fast compiling**

No matter where the file you are editing in, press `F7` to build in `build` directory under the top directory of the project. The quickfix window will popup automatically on error, and press `,n`/`,p` to move around the errors.

### Installation

Backup and remove the original .vimrc and .vim under $HOME, and make a symbol link to rc/vimrc named .vim. It's not needed to create a $HOME/.vimrc. VIM will read the secondary user config file $HOME/.vim/vimrc (at least in Fedora).

```
mv ~/.vimrc ~/.vimrc.bak
mv ~/.vim ~/.vim.bak
ln -s /path/to/where-you-clone-rc/vimrc ~/.vim
```

### Included plugins

The plugins below are included. **It is recommended that read their own documents when using.**

* [vundle](https://github.com/gmarik/Vundle.vim): The plugin manager.
* [YouCompleteMe](https://valloric.github.io/YouCompleteMe/): I think it's the best code completion plugin of VIM.
* [UltiSnips](https://github.com/SirVer/ultisnips): The code snippet engine without any snippets.
* [vim-snippets](https://github.com/honza/vim-snippets): The code snippets.
* [vim-airline](https://github.com/bling/vim-airline): The status line plugin.
* [DoxygenToolkit.vim](https://github.com/karoyqiu/DoxygenToolkit.vim): Comment using [Doxygen](https://www.doxygen.org/) style, forked from [vim-scripts/DoxygenToolkit.vim](https://github.com/vim-scripts/DoxygenToolkit.vim). I changed the leader character from '@' to '\'.
* [vim-template](https://github.com/karoyqiu/vim-template): File template plugin, forked from [aperezdc/vim-template](https://github.com/aperezdc/vim-template). I changed the file header of C/C++ files to Doxygen style.
* [a.vim](https://github.com/vim-scripts/a.vim): Switch between two related files (such as .h and .cpp files).
* [taglist.vim](https://github.com/vim-scripts/taglist.vim): The tag list.

And the plugins they depend on.

### Key mappings

Set the map leader to `,`:

    let mapleader = ","
    let g:mapleader = ","

Fast saving by pressing `,w`: 

    nmap <leader>w :w!<cr>

Treat the long lines as break lines when moving with `j`/`k`:

    map j gj
    map k gk

Press `Space` to search:

    map <space> /

Press `,Enter` to disable highlight:

    map <silent> <leader><cr> :noh<cr>

Search in selections when pressing `*`/`#` in visual mode:

    vnoremap <silent> * :call VisualSelection('f', '')<CR>
    vnoremap <silent> # :call VisualSelection('b', '')<CR>

Press `Ctrl+j/k/h/l` to move around windows: 

    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l

Tab key mappings:

    map <leader>tn :tabnew<cr>
    map <leader>to :tabonly<cr>
    map <leader>tc :tabclose<cr>
    map <leader>tm :tabmove
    map <leader>t<leader> :tabnext

Press `,te` to open a buffer in the same directory of current buffer:

    map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

Map `0` to move to the first non-whitespace character:

    map 0 ^

Quickfix window key mappings:

    map <leader>cc :botright cope<cr>
    map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
    map <leader>n :cn<cr>
    map <leader>p :cp<cr>

Press `,m` to remove ^M in Windows files: 

    noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

Press `,pp` to toggle paste mode: 

    map <leader>pp :setlocal paste!<cr>

My own key mappings are listed below.

Press `F7` to build when editing C/C++ files:

    autocmd FileType c,cpp nnoremap <F7> :make<CR><CR>

Press `Alt+O` to open related file:

    nnoremap <silent> <A-o> :AT<CR>

Press `Alt+G` to go to declaration or definition: 

    nnoremap <silent> <A-g> :YcmCompleter GoTo<CR>

Press `F11` to toggle the tag list: 

    nnoremap <silent> <F11> :TlistToggle<CR>

Press `F12` to comment using Doxygen style: 

    nnoremap <silent> <F12> :Dox<CR>

### Personal Information

The username and email config of vim-template is set at the end of vimrc. You should change it.

    let g:username = "Roy QIU"
    let g:email = "karoyqiu@gmail.com"

## Git

The git's username and email is set in gitconfig. You should change it, too.
Some alias is added as well.

    br = branch
	co = checkout
	st = status

## Others

### Artistic Style

You can read the document of AStyle to see what the astylerc means.

### clang & ccache

Using ccache with clang is not as easy as with gcc. But I've found some script outside the Great Firewall: [here](http://petereisentraut.blogspot.com/2011/05/ccache-and-clang.html) and [here](http://petereisentraut.blogspot.com/2011/09/ccache-and-clang-part-2.html).
Just copy the two scripts to /usr/lib/ccache in Fedora.

    sudo cp scripts/clang* /usr/lib/ccache/
