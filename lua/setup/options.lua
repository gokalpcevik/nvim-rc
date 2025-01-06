vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers for jumps
vim.opt.cursorline = true     -- Highlight the current line
vim.opt.showmatch = true      -- Highlight matching parentheses
vim.opt.termguicolors = true  -- Enable 24-bit RGB colors
-- vim.opt.colorcolumn = '80'    -- Show line length marker

vim.opt.list = true -- Show invisible characters
vim.opt.listchars = {
  tab = '» ', -- Show tabs as special chars
  trail = '·', -- Show trailing spaces
  extends = '›', -- Show when line continues right
  precedes = '‹', -- Show when line continues left
  nbsp = '␣' -- Show non-breaking spaces
}

vim.opt.expandtab = true     -- Use spaces instead of tabs
vim.opt.smartindent = true   -- Smart autoindenting on new lines
vim.opt.tabstop = 2          -- Width of tab character
vim.opt.shiftwidth = 2       -- Width of indentation
vim.opt.autoindent = true    -- Copy indent from current line when starting a new line
vim.opt.breakindent = true   -- Preserve indentation in wrapped lines

vim.opt.ignorecase = true    -- Ignore case when searching
vim.opt.smartcase = true     -- Override ignorecase when search includes uppercase
vim.opt.inccommand = 'split' -- Show live preview of substitute commands

vim.o.modeline = false       -- Disable modeline for security
vim.opt.undofile = true      -- Persistent undo history
vim.opt.backup = false       -- Don't create backup files
vim.opt.writebackup = false  -- Don't create temporary backup while writing
vim.opt.swapfile = false     -- Don't create swap files

vim.o.updatetime = 250       -- Faster completion and cursor hold events
vim.opt.timeoutlen = 500     -- Time to wait for mapped sequences
vim.opt.mouse = 'a'          -- Enable mouse support in all modes

vim.opt.splitright = true    -- Open new vertical splits on the right
vim.opt.splitbelow = true    -- Open new horizontal splits below
vim.opt.scrolloff = 8        -- Keep 8 lines above/below cursor when scrolling
vim.opt.sidescrolloff = 8    -- Keep 8 columns left/right of cursor when scrolling

vim.opt.confirm = true       -- Ask for confirmation instead of erroring

vim.opt.wrap = false         -- Don't wrap lines by default
vim.opt.linebreak = true     -- Break lines at word boundaries when wrap is enabled

vim.diagnostic.config({
  virtual_text = false,       -- Disable inline virtual text
  signs = true,               -- Show signs in the sign column
  underline = true,           -- Underline diagnostic locations
  update_in_insert = false,   -- Don't update diagnostics in insert mode
  severity_sort = true,       -- Sort diagnostics by severity
  float = {
    focusable = false,        -- Make floating windows non-focusable
    style = "minimal",        -- Minimal window style
    border = "rounded",       -- Add rounded borders
    source = "always",        -- Always show source
    header = "",              -- No header
    prefix = "",              -- No prefix
  },
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float({ focusable = false })
  end
})


