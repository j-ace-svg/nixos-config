local Remap = require("j-ace-svg.keymap")
local nnrm = Remap.nnoremap
local inrm = Remap.inoremap
local onrm = Remap.onoremap
local cnrm = Remap.cnoremap
local vnrm = Remap.vnoremap
local tnrm = Remap.tnoremap
local nmap = Remap.nmap
local ia = Remap.ia
local ca = Remap.ca

if vim.g.started_by_firenvim == true then
  vim.api.nvim_set_keymap("n", "<Esc><Esc>", "<Cmd>call firenvim#focus_page()<CR>", {})
  vim.opt_local.signcolumn = "no"
  vim.opt.colorcolumn = ""
  vim.opt.laststatus = 0
end
