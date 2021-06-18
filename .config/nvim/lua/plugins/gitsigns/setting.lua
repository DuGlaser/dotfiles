require('gitsigns').setup{
    signs = {
      add          = {hl = 'GitGutterAdd'   },
      change       = {hl = 'GitGutterChange'},
      delete       = {hl = 'GitGutterDelete'},
      topdelete    = {hl = 'GitGutterDelete'},
      changedelete = {hl = 'GitGutterChange'},
    },
    keymaps = {
      -- Text objects
      ['o ig'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
      ['x ig'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
    }
}
