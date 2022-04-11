local nvim_tree = require('nvim-tree')

nvim_tree.setup{
  actions = {
    quit_on_open = true
  },
  hijack_cursor = true,
  open_on_setup = true,
}

