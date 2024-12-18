local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",

    layout_config = {
      horizontal = {
        preview_width = 0.6, -- wider preview
        results_width = 0.4,
      },
      width = 0.95,         -- use more screen space
      height = 0.90,
      preview_cutoff = 120, -- show preview when window is wider than this
    },

    file_ignore_patterns = {
      "%.git/",
      "node_modules",
      "build/",
      "dist/",
      "%.o",
      "%.a",
      "%.out",
      "%.class",
      "%.pdf",
      "%.mkv",
      "%.mp4",
      "%.zip",
      "%.csv"
    },

    sorting_strategy = "ascending",

    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-u>"] = false,
        ["<C-d>"] = false,
        ["<C-b>"] = actions.preview_scrolling_up,
        ["<C-f>"] = actions.preview_scrolling_down,
        ["<C-/>"] = action_layout.toggle_preview,

        ["<C-s>"] = actions.select_horizontal, -- open in horizontal split
        ["<C-v>"] = actions.select_vertical,   -- open in vertical split
        ["<C-t>"] = actions.select_tab,        -- open in new tab

        ["<C-y>"] = actions.file_edit,         -- create file if it doesn't exist
      },
    },
  },

  pickers = {
    find_files = {
      hidden = true,     -- show hidden files
      no_ignore = false, -- respect gitignore
      follow = true,     -- follow symlinks
    },
    live_grep = {
      additional_args = function()
        return { "--hidden" } -- search in hidden files
      end
    },
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer,
        }
      }
    },
  },

  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  }
})

pcall(telescope.load_extension, 'fzf')

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = true
  opts.noremap = true
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- File navigation
map('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
map('n', '<leader>fw', builtin.grep_string, { desc = 'Grep word under cursor' })
map('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })

-- Code navigation
map('n', '<leader>ss', builtin.lsp_dynamic_workspace_symbols, { desc = 'Workspace symbols' })
map('n', '<leader>sr', builtin.lsp_references, { desc = 'Find references' })
map('n', '<leader>sd', builtin.lsp_definitions, { desc = 'Go to definition' })
map('n', '<leader>si', builtin.lsp_implementations, { desc = 'Find implementations' })

-- Project navigation
map('n', '<leader>jg', builtin.git_files, { desc = 'Find git files' })
map('n', '<leader>js', builtin.git_status, { desc = 'Git status' })
map('n', '<leader>jc', builtin.git_commits, { desc = 'Git commits' })

-- Help and documentation
map('n', '<leader>hh', builtin.help_tags, { desc = 'Help tags' })
map('n', '<leader>hm', builtin.man_pages, { desc = 'Man pages' })
map('n', '<leader>hk', builtin.keymaps, { desc = 'Show keymaps' })

-- Diagnostics and problems
map('n', '<leader>dd', builtin.diagnostics, { desc = 'Document diagnostics' })
map('n', '<leader>dw', function()
  builtin.diagnostics({ severity = vim.diagnostic.severity.WARNING })
end, { desc = 'Warning diagnostics' })
map('n', '<leader>de', function()
  builtin.diagnostics({ severity = vim.diagnostic.severity.ERROR })
end, { desc = 'Error diagnostics' })

-- Settings and customization
map('n', '<leader>cs', builtin.colorscheme, { desc = 'Choose colorscheme' })
map('n', '<leader>ct', builtin.treesitter, { desc = 'Treesitter symbols' })
