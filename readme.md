### Setup Instructions in case I forget
_Before_ running __:PlugInstall__
* Make sure npm/yarn is installed globally
* Set up environment for neovim's python interpreter. Requires at least python 3.6 for `black`.
  * Currently using a miniconda environment named `nvim`. If this changes, alter the path in `.vimrc`.
  
_After_ running __:PlugInstall__
* Move anything in `plugin_mods` to its corresponding directory in `bundle` _after_. If I didn't screw up, it should be trivial.
* Hard link `coc-settings.json` in `.config/nvim` to `coc-settings.json` in `.vim`
