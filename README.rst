****
.vim
****

Plugins are included as submodules and managed using `pathogen <https://github.com/tpope/vim-pathogen>`_.

Installation
============

#. ``git clone --recursive git://github.com/0/.vim.git ~/.vim``
#. ``ln -s ~/.vim/vimrc ~/.vimrc``
#. ``vim +:Helptags +qa``

Command-T
---------

``:help command-t-installation``

notes.vim
---------

``mkdir -p ~/notes.d/user``

splice.vim
----------

``:help SpliceVCS``

taglist.vim
-----------

Install `Exuberant Ctags <http://ctags.sourceforge.net/>`_.

Updating
========

#. ``git pull``
#. ``git submodule update --init``
#. ``vim +:Helptags +qa``
