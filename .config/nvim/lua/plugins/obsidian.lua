return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = "markdown",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
  },

  opts = {
    completion = {
      dir = "~/Documents/ObsidianVault",
      nvim_cmp = true,
      min_chars = 2,
    },

    workspaces = {
      {
        name = "primary_vault",
        path = vim.fn.expand("~/Documents/ObsidianVault"),
        overrides = {
          notes_subdir = "inbox",
          new_notes_location = "notes_subdir",
          daily_notes = {
            folder = "dailies",
            date_format = "%Y-%m-%d",
          },
        },
      },
    },

    -- Optional, for templates (see below).
    templates = {
      folder = "Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },

    log_level = vim.log.levels.INFO,

    daily_notes = {
      folder = "notes/dailies",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      default_tags = { "daily-notes" },
      template = "daily.md",
    },

    mappings = {
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      ["<leader>o"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
      ["<leader>ot"] = { action = ":ObsidianTemplate<CR>", opts = { noremap = true, silent = true, buffer = true } }, -- Added for templates
    },

    new_notes_location = "notes_subdir",

    note_id_func = function(title)
      return title and title:lower():gsub("%s+", "-") or tostring(os.time())
    end,
    -- note_id_func = function(title)
    --   if title then
    --     return title:gsub("[^%w%-_ ]", ""):gsub("%s+", "-"):lower()
    --   end
    --   return tostring(os.time())
    -- end,

    note_path_func = function(spec)
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix(".md")
    end,

    wiki_link_func = function(opts)
      return require("obsidian.util").wiki_link_id_prefix(opts)
    end,

    markdown_link_func = function(opts)
      return require("obsidian.util").markdown_link(opts)
    end,

    preferred_link_style = "wiki",

    disable_frontmatter = false,

    note_frontmatter_func = function(note)
      if note.title then
        note:add_alias(note.title)
      end
      local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,

    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url })
    end,

    follow_img_func = function(img)
      vim.fn.jobstart({ "qlmanage", "-p", img })
    end,

    picker = {
      name = "telescope.nvim",
      note_mappings = { new = "", insert_link = "" },
      tag_mappings = { tag_note = "", insert_tag = "" },
    },

    sort_by = "modified",
    sort_reversed = true,

    search_max_lines = 1000,

    open_notes_in = "current",

    ui = { enable = true },

    attachments = {
      img_folder = "assets/imgs",
      img_name_func = function()
        return string.format("%s-", os.time())
      end,
      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format("![%s](%s)", path.name, path)
      end,
    },
  },
}
