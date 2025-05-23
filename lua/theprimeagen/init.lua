require("theprimeagen.set")
require("theprimeagen.remap")
require("theprimeagen.lazy")
-- DO NOT INCLUDE THIS
-- vim.opt.rtp:append("~/personal/streamer-tools")
-- DO NOT INCLUDE THIS

--vim.cmd.packadd('YouCompleteMe')

vim.cmd('colorscheme base16-gruvbox-dark-hard')

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd({"BufReadPost","FileReadPost"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = "normal zR",
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
