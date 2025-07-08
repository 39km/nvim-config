# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Neovim configuration based on LazyVim distribution with custom plugins and settings.

## Common Commands

### Plugin Management
- `:Lazy` - Open lazy.nvim plugin manager UI
- `:Lazy sync` - Update all plugins
- `:Lazy install` - Install missing plugins
- `:Lazy clean` - Remove unused plugins

### Formatting and Linting
- `:Format` - Format current buffer using configured formatters (Prettier/ESLint)
- `:EslintFixAll` - Fix all ESLint errors in current buffer
- `:ConformInfo` - Show formatting information for current buffer

### LSP Commands
- `:LspInfo` - Show LSP server information
- `:Mason` - Open Mason UI to manage language servers, formatters, and linters

## Architecture

### Directory Structure
- `init.lua` - Entry point that loads LazyVim
- `lua/config/` - Core configuration files
  - `lazy.lua` - Plugin manager setup
  - `options.lua` - Vim options (ESLint auto-format enabled)
  - `keymaps.lua` - Custom keybindings
  - `autocmds.lua` - Custom autocommands
- `lua/plugins/` - Plugin configurations (one file per plugin/feature)
  - `colorscheme.lua` - Tokyo Night theme configuration
  - `prettier.lua` - Prettier formatter setup
  - `eslint.lua` - ESLint linter and formatter setup
  - `typescript.lua` - TypeScript language support
  - `treesitter.lua` - Syntax highlighting configuration
  - Other plugin-specific configurations

### Key Features
- **Plugin Manager**: lazy.nvim for fast, lazy-loaded plugins
- **Language Support**: TypeScript/JavaScript with full LSP, formatting, and linting
- **Formatters**: Prettier (for JS/TS/JSON/etc.) and ESLint (for JS/TS)
- **Code Intelligence**: LSP servers managed by Mason
- **Version Control**: Plugin versions locked in `lazy-lock.json`

### Configuration Philosophy
- Extends LazyVim defaults rather than replacing them
- Modular configuration with one file per feature
- Minimal custom configuration, leveraging LazyVim's sensible defaults
- Format on save enabled for supported file types