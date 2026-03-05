return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  cond = vim.version().minor >= 11,
}
