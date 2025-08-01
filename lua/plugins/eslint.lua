return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
            format = true,
          },
        },
      },
      setup = {
        eslint = function()
          local function get_client(buf)
            return require("lazyvim.util").lsp.get_clients({ name = "eslint", bufnr = buf })[1]
          end

          local formatter = require("lazyvim.util").lsp.formatter({
            name = "eslint: lsp",
            primary = false,
            priority = 200,
            filter = "eslint",
          })

          -- Use EslintFixAll on Neovim < 0.10.0
          if not pcall(require, "vim.lsp._dynamic") then
            formatter.name = "eslint: EslintFixAll"
            formatter.sources = function(buf)
              local client = get_client(buf)
              return client and { "eslint" } or {}
            end
            formatter.format = function(buf)
              local client = get_client(buf)
              if client then
                local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                if #diag > 0 then
                  vim.cmd("EslintFixAll")
                end
              end
            end
          end

          -- register the formatter with LazyVim
          require("lazyvim.util").format.register(formatter)
        end,
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, require("none-ls.diagnostics.eslint_d"))
    end,
  },
}