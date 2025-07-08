return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettier",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      local supported = {
        "css",
        "graphql",
        "handlebars",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "less",
        "markdown",
        "markdown.mdx",
        "scss",
        "typescript",
        "typescriptreact",
        "vue",
        "yaml",
      }

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "prettier")
      end

      opts.formatters = opts.formatters or {}
      opts.formatters.prettier = {
        condition = function(_, ctx)
          local has_parser = function(parser)
            local prettier = vim.fs.find_up(".prettierrc", { path = ctx.filename, stop = vim.fn.getcwd() })
              or vim.fs.find_up(".prettierrc.json", { path = ctx.filename, stop = vim.fn.getcwd() })
              or vim.fs.find_up(".prettierrc.yml", { path = ctx.filename, stop = vim.fn.getcwd() })
              or vim.fs.find_up(".prettierrc.yaml", { path = ctx.filename, stop = vim.fn.getcwd() })
              or vim.fs.find_up(".prettierrc.json5", { path = ctx.filename, stop = vim.fn.getcwd() })
              or vim.fs.find_up(".prettierrc.js", { path = ctx.filename, stop = vim.fn.getcwd() })
              or vim.fs.find_up(".prettierrc.cjs", { path = ctx.filename, stop = vim.fn.getcwd() })
              or vim.fs.find_up("prettier.config.js", { path = ctx.filename, stop = vim.fn.getcwd() })
              or vim.fs.find_up("prettier.config.cjs", { path = ctx.filename, stop = vim.fn.getcwd() })
            return prettier ~= nil
          end
          
          local has_config = function(context)
            return vim.fs.find_up({
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.json5",
              ".prettierrc.js",
              ".prettierrc.cjs",
              "prettier.config.js",
              "prettier.config.cjs",
            }, { path = context.filename, stop = vim.fn.getcwd() })[1] ~= nil
          end

          return has_parser(ctx) and (vim.g.lazyvim_prettier_needs_config ~= true or has_config(ctx))
        end,
      }
    end,
  },
}