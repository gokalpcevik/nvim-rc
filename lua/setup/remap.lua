vim.g.mapleader = " "
-- Save with Left CTRL + S
vim.keymap.set("n", "<C-s>", vim.cmd.w)
-- Add a new line below in normal mode with <Enter>
vim.keymap.set("n", "<Enter>", "o<ESC>")

local window_maps = {
    -- Vertical split with <Leader>v
    -- Creates a new window on the right
    ["<Leader>v"] = ":vsplit<CR>",

    -- Horizontal split with <Leader>h
    -- Creates a new window below
    ["<Leader>h"] = ":split<CR>",

    -- Quick window navigation using Ctrl + hjkl
    ["<C-h>"] = "<C-w>h",  -- Move to left window
    ["<C-j>"] = "<C-w>j",  -- Move to window below
    ["<C-k>"] = "<C-w>k",  -- Move to window above
    ["<C-l>"] = "<C-w>l",  -- Move to right window

    ["<M-Left>"] = function()
        -- If we're in a window on the right side, we need to increase size when going left
        if vim.fn.winnr() > vim.fn.winnr('h') then
            vim.cmd('vertical resize +2')
        else
            vim.cmd('vertical resize -2')
        end
    end,
    ["<M-Right>"] = function()
        -- If we're in a window on the right side, we need to decrease size when going right
        if vim.fn.winnr() > vim.fn.winnr('h') then
            vim.cmd('vertical resize -2')
        else
            vim.cmd('vertical resize +2')
        end
    end,
    ["<M-Up>"] = function()
        -- Similar logic for vertical splits
        if vim.fn.winnr() > vim.fn.winnr('k') then
            vim.cmd('resize +2')
        else
            vim.cmd('resize -2')
        end
    end,
    ["<M-Down>"] = function()
        -- Similar logic for vertical splits
        if vim.fn.winnr() > vim.fn.winnr('k') then
            vim.cmd('resize -2')
        else
            vim.cmd('resize +2')
        end
    end,

    -- Quick window size adjustments
    ["<Leader>="] = "<C-w>=",  -- Make all windows equal size
    ["<Leader>_"] = "<C-w>_",  -- Maximize height
    ["<Leader>|"] = "<C-w>|",  -- Maximize width
}

for key, cmd in pairs(window_maps) do
    vim.keymap.set('n', key, cmd, { silent = true, noremap = true })
end

vim.opt.splitbelow = true    -- Open horizontal splits below current window
vim.opt.splitright = true    -- Open vertical splits to the right
vim.opt.equalalways = true   -- Make splits equal size by default

