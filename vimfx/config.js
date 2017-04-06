vimfx.addCommand({
  name: 'copy_markdown',
  description: 'Copy url and title as markdown style',
}, ({vim}) => {
  vim.notify('start copy md')
  const url = vim.window.gBrowser.selectedBrowser.currentURI.spec
  const title = vim.window.gBrowser.selectedBrowser.contentTitle
  const text = '[' + title + '](' + url + ')'
  gClipboardHelper.copyString(text)
  vim.notify('Copied String: ' + text)
})

vimfx.addCommand({
  name: 'copy_title',
  description: 'Copy title',
  category: 'location',
}, ({vim}) => {
  const title = vim.window.gBrowser.selectedBrowser.contentTitle
  gClipboardHelper.copyString(title)
  vim.notify('Copied String: ' + title)
})
