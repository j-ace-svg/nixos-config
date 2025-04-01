local M = {}

local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

local function abbreviate(op)
    return function(lhs, rhs)
        vim.cmd(op .. "abb " .. lhs:gsub("%s+", " ") .. " " .. rhs:gsub("%s+", " "))
    end
end

M.map = bind("", {noremap = false})
M.nmap = bind("n", {noremap = false})
M.imap = bind("i", {noremap = false})
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")
M.lnoremap = bind("l")
M.onoremap = bind("o")
M.cnoremap = bind("c")
M.tnoremap = bind("t")

M.ia = abbreviate("i")
M.ca = abbreviate("c")

return M
