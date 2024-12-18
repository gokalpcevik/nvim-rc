local M = {}

function M.setup(opts)
  local cmp = require('cmp')

  cmp.setup(opts)

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'conventional_commits' },
      { name = 'buffer' }
    })
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
      {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!', 'lua' }
        }
      }
    })
  })

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })
end

return M
