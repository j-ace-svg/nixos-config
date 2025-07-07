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

-- Exiting insert mode
inrm("jk", "<Right><Esc>")
inrm("kj", "<Right><Esc>")
-- Completion
inrm("<C-e>", "<C-x>")
inrm("<C-t>", "<C-x>")
inrm("<C-y>", "<C-o>")
inrm("<C-o>", "<C-x><C-o>")

-- File/session management
nnrm("<Leader>w", ":w<CR>", {silent = true})
nnrm("<Leader>W", ":wa<CR>", {silent = true})
nnrm("<Leader>q", ":q<CR>", {silent = true})
nnrm("<Leader>Q", ":q!<CR>", {silent = true})
nnrm("<Leader>o", ":wq<CR>", {silent = true})
nnrm("<Leader>O", ":wqa<CR>", {silent = true})

-- Access command mode easier
nnrm(",", ":")
nnrm(";", ",")
nnrm(":", ";")

-- Command mode
cnrm("<C-t>", "<C-R>=expand('%:h')<cr>/")
