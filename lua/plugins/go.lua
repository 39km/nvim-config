return {
  -- LSP 설정
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {},
      },
    },
  },

  -- nvim-dap 설정
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- nvim-dap doesn't require setup() to be called
      -- Configuration will be handled by go.nvim
    end,
  },

  -- Go-specific 기능 추가 (선택사항)
  {
    "ray-x/go.nvim",
    dependencies = {  -- go.nvim은 plenary와 nvim-dap이 필요
      "ray-x/guihua.lua",
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("go").setup()
    end,
    ft = { "go", "gomod" },
  },
}
