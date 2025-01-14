local lsp_zero = require('lsp-zero')
lsp_zero.extend_lspconfig()

-- LSP On attach
lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })

  if client.name == "clangd" then
    vim.keymap.set("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>")
  end
end)

-- Mason for some off-the-shelf LSPs
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,

    lua_ls = function()
      local neodev_opts = require('setup.neodev')
      require('neodev').setup(neodev_opts)
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

require('lspconfig').clangd.setup({
  single_file_support = true,
  capabilities = (function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.insertTextMode = 1
    capabilities.textDocument.completion.completionItem.preselectSupport = true
    capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    return capabilities
  end)(),
  cmd = {
    "clangd",
    "--header-insertion=never",
    "--clang-tidy",
    "--clang-tidy-checks=*",
  },
})

-- Virtual text is disabled, so this is how we do it. Hover over any diagnostic and it shall show it in a floating window.
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
