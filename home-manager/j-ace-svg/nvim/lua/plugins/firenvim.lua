return {
  "glacambre/firenvim",
  build = ":call firenvim#install(0)",
  init = function()
    vim.g.firenvim_config = {
      globalSettings = {
        ['<C-w>'] = 'noop',
        ['<C-n>'] = 'default'
      }
    }
  end
}
