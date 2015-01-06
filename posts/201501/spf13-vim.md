# [spf13 github](https://github.com/spf13/spf13-vim)


## shortcut key
ctrlp: <c-p>
NERDTree: <c-e>
NERDCommenter: <Leader>c<space>

### A highly optimized .vimrc config file

It fixes many of the inconveniences of vanilla vim including

  * A single config can be used across Windows, Mac and linux
  * Eliminates swap and backup files from littering directories, preferring to store in a central location.
  * Fixes common typos like :W, :Q, etc
  * Setup a solid set of settings for Formatting (change to meet your needs)
  * Setup the interface to take advantage of vim's features including
    * omnicomplete
    * line numbers
    * syntax highlighting
    * A better ruler & status line
    * & more
  * Configuring included plugins

### Customization

Create ~/.vimrc.local and ~/.gvimrc.local for any local customizations.

For example, to override the default color schemes:

    echo colorscheme ir_black  >> ~/.vimrc.local

### Before File

Create a ~/.vimrc.before.local file to define any customizations that get loaded before the spf13-vim .vimrc.

For example, to prevent autocd into a file directory:

    echo let g:spf13_no_autochdir = 1 >> ~/.vimrc.before.local


### Fork Customization

There is an additional tier of customization available to those who want to maintain a
fork of spf13-vim specialized for a particular group. These users can create `.vimrc.fork`
and `.vimrc.bundles.fork` files in the root of their fork.  The load order for the configuration is:

1. `.vimrc.before.local` - before user configuration
2. `.vimrc.before.fork` - fork before configuration
3. `.vimrc.bundles.local` - local user bundle configuration
4. `.vimrc.bundles.fork` - fork bundle configuration
5. `.vimrc.bundles` - spf13-vim bundle configuration
6. `.vimrc` - spf13-vim vim configuration
7. `.vimrc.fork` - fork vim configuration
8. `.vimrc.local` - local user configuration