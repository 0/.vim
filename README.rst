****
.vim
****

Plugins are included as submodules and managed using `pathogen <https://github.com/tpope/vim-pathogen>`_.

Installation
============

#. ``git clone --recursive https://github.com/0/.vim.git ~/.vim``
#. ``ln -s ~/.vim/vimrc ~/.vimrc``
#. ``vim +:Helptags +qa``

splice
------

``:help SpliceVCS``

vimproc
-------

``:help vimproc-install``

Updating
========

#. ``git pull``
#. ``git submodule update --init --recursive``
#. ``vim +:Helptags +qa``
#. Rebuild plugins as necessary.

Plugin dependencies
===================

Some plugins are not interesting on their own, but are included to satisfy dependencies of other plugins:

* CountJump: ConflictMotions
* ingo-library: ConflictDetection, ConflictMotions
* repeat: various (typically optional)
* vimproc: unite, vinarise
* xolox-misc: notes

Workarounds
===========

Certain plugins require workarounds. The current list includes:

a
-

It creates mappings that get in the way of typing. Fixed in
``after/plugin/a.vim``.
