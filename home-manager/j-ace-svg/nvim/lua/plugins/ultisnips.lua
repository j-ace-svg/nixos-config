return {
  "SirVer/ultisnips",
  event = "InsertEnter",
  ft = "snippets",
  init = function()
    vim.g.UltiSnipsSnippetDirectories = { "UltiSnips" }
    vim.g.UltiSnipsExpandTrigger = "<tab>"
    vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
    vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
  end
}
