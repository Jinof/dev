set ts=4
set shiftwidth=4
set ai
set nu
syntax enable
colorscheme koehler

call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
call plug#end()

lua << EOF

local lspconfig = require'lspconfig'

lspconfig.gopls.setup{}
lspconfig.rust_analyzer.setup{}

lspconfig.ccls.setup {
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
}
EOF
