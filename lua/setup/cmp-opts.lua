local cmp = require('cmp')
local lspzero = require('lsp-zero')
local cmp_action = lspzero.cmp_action()

lspzero.extend_cmp()

-- Base colors
local colors = {
  deprecated = '#808080',
  match = '#569CD6',
  variable = '#9CDCFE',
  function_color = '#C586C0',
  keyword = '#D4D4D4',
  type = '#4EC9B0',
  constant = '#4FC1FF',
  field = '#B5CEA8'
}

local function setup_highlights()
  local highlights = {
    CmpItemAbbrDeprecated = { bg = 'NONE', strikethrough = true, fg = colors.deprecated },
    CmpItemAbbrMatch = { bg = 'NONE', fg = colors.match },
    CmpItemAbbrMatchFuzzy = { bg = 'NONE', fg = colors.match },

    CmpItemKindVariable = { bg = 'NONE', fg = colors.variable },
    CmpItemKindFunction = { bg = 'NONE', fg = colors.function_color },
    CmpItemKindClass = { bg = 'NONE', fg = colors.type },
    CmpItemKindConstant = { bg = 'NONE', fg = colors.constant },
    CmpItemKindField = { bg = 'NONE', fg = colors.field }
  }

  -- Apply highlights
  for group, settings in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

setup_highlights()

return {
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = require('lspkind').cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
      -- Add before to show nice spacing
      before = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          path = "[Path]",
          buffer = "[Buffer]",
          luasnip = "[Snippet]"
        })[entry.source.name]
        return vim_item
      end
    })
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
  window = {
    completion = {
      border = "rounded",
      winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel",
      col_offset = -3,
      side_padding = 1,
    },
    -- Improve documentation display
    documentation = {
      max_height = 20,
      max_width = 80,
      border = "rounded",
      col_offset = 1,
      side_padding = 1,
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({
      select = false,
      behavior = cmp.ConfirmBehavior.Replace
    }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp',   priority = 1000 },
    { name = 'treesitter', priority = 750 }, -- Add treesitter completion
    { name = 'luasnip',    priority = 750 },
    { name = 'path',       priority = 500 },
    { name = 'buffer',     priority = 250,    keyword_length = 3 },
    { name = 'calc' },                           -- Adds inline calculation completion
    { name = 'spell',      keyword_length = 4 }, -- Helps with variable naming
  }),
  experimental = {
    ghost_text = true -- Shows virtual text preview
  },
  completion = {
    keyword_length = 2,         -- Start completing after 2 characters
    keyword_pattern = [[\k\+]], -- Include underscore in keyword pattern
    completeopt = 'menu,menuone,noinsert',
  },

  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
}


