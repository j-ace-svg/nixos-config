vim.cmd.colorscheme("gruvbox")

if vim.g.started_by_firenvim == false then
  vim.api.nvim_set_hl(0, 'Normal', {guibg=nil})
  vim.api.nvim_set_hl(0, 'NonText', {guibg=nil})
  vim.api.nvim_set_hl(0, 'Normal', {ctermbg=nil})
  vim.api.nvim_set_hl(0, 'NonText', {ctermbg=nil})
end
