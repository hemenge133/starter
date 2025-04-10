-- ~/.config/nvim/lua/custom/plugins/init.lua

return {
  -- Disable NvChad's default dashboard plugin correctly
  { "goolord/alpha-nvim", enabled = false },

  -- User's original dashboard-nvim config
  {
    'glepnir/dashboard-nvim',
    lazy = false, -- Keep this to ensure loading
    config = function()
      -- Helper function for center items
      local function key(shortcut)
        shortcut.icon_hl = shortcut.icon_hl or "Title"
        shortcut.desc_hl = shortcut.desc_hl or "String"
        shortcut.key_hl = shortcut.key_hl or "Keyword"
        return shortcut
      end
      -- Safe require for ascii
      local ascii = nil
      local ok, ascii_mod = pcall(require, "ascii")
      if ok then
        ascii = ascii_mod
      else
         vim.notify("ascii.nvim failed to load!", vim.log.levels.WARN) -- Add warning if ascii fails
      end

      require("dashboard").setup {
        theme = "doom",
        config = {
          header = ascii and ascii.get_random and ascii.get_random("text", "neovim") or { "[ASCII Failed To Load]" },
          center = {
            key { icon = "  ", desc = "Restore Session", key = "s", action = "SessionRestore" },
            key { icon = "  ", desc = "Recent Files",    key = "fo", action = "Telescope oldfiles" },
            key { icon = " ",  desc = "New File",        key = "n",  action = "enew"},
            key { icon = "  ", desc = "Find Files",      key = "ff", action = "Telescope find_files" },
            key { icon = "  ", desc = "Find Word",       key = "fw", action = "Telescope live_grep" },
            key { icon = "󰒲  ", desc = "Plugins",         key = "l",  action = "Lazy" },
          },
          footer = {""},
        }
      }
      vim.notify("Original dashboard setup called!", vim.log.levels.INFO) -- Update notification
    end,
    dependencies = {
      {'nvim-tree/nvim-web-devicons'},
      {'MaximilianLloyd/ascii.nvim'}
    }
  },
} 