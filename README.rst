****
.vim
****

Plugins are included as submodules and managed using `pathogen <https://github.com/tpope/vim-pathogen>`_.

Installation
============

#. ``git clone --recursive git://github.com/0/.vim.git ~/.vim``
#. ``ln -s ~/.vim/vimrc ~/.vimrc``
#. ``vim +:Helptags +qa``

splice
------

``:help SpliceVCS``

vimproc
-------

Used by unite.

``:help vimproc-install``

Updating
========

#. ``git pull``
#. ``git submodule update --init --recursive``
#. ``vim +:Helptags +qa``

Workarounds
===========

Certain plugins require workarounds. The current list includes:

a
-

It creates mappings that get in the way of typing. Fixed in
``after/plugin/a.vim``.
