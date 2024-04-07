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
  { 'projekt0n/github-nvim-theme',            lazy = false },
  { "nvim-treesitter/nvim-treesitter-angular" }
}

-- Custom config
lvim.colorscheme = "catppuccin"
lvim.format_on_save.enabled = true
lvim.builtin.treesitter.highlight.enable = true
vim.wo.relativenumber = true
require("lvim.lsp.manager").setup("angularls")

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
