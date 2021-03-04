// Configure CodeMirror Keymap
require([
  'nbextensions/vim_binding/vim_binding',   // depends your installation
], function() {
  // Map jj to <Esc>
  // CodeMirror.Vim.map('<Ctrl>l', '<End>', 'insert')
  CodeMirror.Vim.map('Ctrl-L', '$', 'normal')
  CodeMirror.Vim.map('Ctrl-H', '^', 'normal')

  // Swap j/k and gj/gk (Note that <Plug> mappings)
  CodeMirror.Vim.map('Ctrl-T', '<Backspace>', 'insert')
  // CodeMirror.Vim.map('j', '<Plug>(vim-binding-gj)', 'normal')
  // CodeMirror.Vim.map('k', '<Plug>(vim-binding-gk)', 'normal')
  // CodeMirror.Vim.map('gj', '<Plug>(vim-binding-j)', 'normal')
  // CodeMirror.Vim.map('gk', '<Plug>(vim-binding-k)', 'normal')
  // CodeMirror.Vim.map('jj', '<Esc>', 'insert')

  // https://qiita.com/pollenjp/items/f228c849806bd5704754
  // https://github.com/lambdalisue/jupyter-vim-binding/wiki/Customization
  CodeMirror.Vim.defineAction('[i]<C-h>', function(cm) {
    var head = cm.getCursor()
    CodeMirror.Vim.handleKey(cm, '<Esc>')      // Inesrt Modeから出る

    var last = cm.getLine(head.line).length
    CodeMirror.Vim.handleKey(cm, 'x')          // 最後の行を削除する
    if (head.ch === last){                  // カーソルが最後の文字か
      CodeMirror.Vim.handleKey(cm, 'a')        // 後ろに挿入
    } else {
      CodeMirror.Vim.handleKey(cm, 'i')        // 前に挿入
    }
  })
  CodeMirror.Vim.mapCommand('<C-h>', 'action', '[i]<C-h>', {}, { 'context': 'insert' })

})

// Configure Jupyter Keymap
require([
  'nbextensions/vim_binding/vim_binding',
  'base/js/namespace',
], function(vim_binding, ns) {
  // Add post callback
  vim_binding.on_ready_callbacks.push(function(){
    var km = ns.keyboard_manager
    // Allow Ctrl-2 to change the cell mode into Markdown in Vim normal mode
    // km.edit_shortcuts.add_shortcut('ctrl-2', 'vim-binding:change-cell-to-markdown', true)

    // Update Help
    km.edit_shortcuts.events.trigger('rebuild.QuickHelp')
  })
})
