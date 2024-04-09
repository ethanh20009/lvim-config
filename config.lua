-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
-- Plugin table
lvim.plugins = {
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
  { "catppuccin/nvim",      name = "catppuccin" },
  {
    "sindrets/diffview.nvim",
    opts = {
      enhanced_diff_hl = true
    },
    event = "BufRead",
  },
  {
    "folke/lsp-colors.nvim",
    event = "BufRead",
  },
  { "rose-pine/neovim",     name = "rose-pine" },
  { "lunarVim/colorschemes" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {},
  },
  { 'projekt0n/github-nvim-theme',     lazy = false },
  { "nvim-treesitter/nvim-treesitter", commit = "fbe7621" },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "angular.html", "typescript", "typescriptreact", "html", "scss", "json" },
  },
}

-- Custom config
lvim.colorscheme = "catppuccin"
lvim.format_on_save.enabled = true
lvim.builtin.treesitter.highlight.enable = true
vim.wo.relativenumber = true
require("lvim.lsp.manager").setup("angularls", {
  filetypes = {
    "angular.html",
    "typescript",
    "tsx",
    "html",
    "scss",
    "css"
  }
})

require("lvim.lsp.manager").setup("html", {
  filetypes = {
    "angular.html",
    "html"
  }
})
-- Custom which-key bindings
local wk = require("which-key")
wk.register({
  v = {
    name = "Diff View",
    v = { "<cmd>DiffviewOpen<cr>", "Open Diff" },
    c = { "<cmd>DiffviewClose<cr>", "Close Diff" }
  }
}, {
  prefix = "<leader>"
})

--Angular custom treesitter
vim.filetype.add({
  pattern = {
    [".*%.component%.html"] = "angular.html", -- Sets the filetype to `angular.html` if it matches the pattern
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "angular.html",
  callback = function()
    vim.treesitter.language.register("angular", "angular.html") -- Register the filetype with treesitter for the `angular` language/parser
  end,
})
