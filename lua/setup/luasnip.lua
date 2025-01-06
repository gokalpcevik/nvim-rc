local ls = require("luasnip")

ls.setup({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [require("luasnip.util.types").choiceNode] = {
      active = {
        virt_text = { { "●", "GruvboxOrange" } },
      },
    },
  },
  store_selection_keys = "<Tab>",
  enable_nested_snippets = true,
  
  -- Add these new settings for better LSP snippet support
  region_check_events = "InsertEnter",
  delete_check_events = "TextChanged,InsertLeave",
  
  -- Environment for snippets
  snip_env = {
    s = ls.snippet,
    sn = ls.snippet_node,
    isn = ls.indent_snippet_node,
    t = ls.text_node,
    i = ls.insert_node,
    f = ls.function_node,
    c = ls.choice_node,
    d = ls.dynamic_node,
    events = require("luasnip.util.events"),
    parse = require("luasnip.util.parser").parse_snippet,
  },
})

-- Load VSCode-style snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Add snippet support between C and C++
require("luasnip").filetype_extend("cpp", { "c" })
require("luasnip").filetype_extend("c", { "cpp" })

-- This helps with snippet expansion debugging
ls.log.set_loglevel("info")
vim.api.nvim_create_autocmd("User", {
  pattern = "LuasnipCleanup",
  callback = function()
    print("Luasnip cleanup triggered")
  end,
})
