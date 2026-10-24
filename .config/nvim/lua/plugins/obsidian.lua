return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  -- :Obsidian доступна и вне markdown (глобальные <leader>o* в keymaps.lua)
  cmd = "Obsidian",

  keys = {
    { "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian: Quick switch" },
  },

  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- только `:Obsidian <subcommand>`, старые ObsidianXxx уберут в 4.0

    workspaces = {
      {
        name = "primary_vault",
        path = vim.fn.expand("~/Documents/ObsidianVault"),
        overrides = {
          notes_subdir = "inbox",
          new_notes_location = "notes_subdir",
        },
      },
    },

    notes_subdir = "inbox",
    new_notes_location = "notes_subdir",

    -- автодополнение ([[, #) даёт встроенный LSP плагина: работает с blink.cmp без настройки
    completion = {
      min_chars = 2,
    },

    picker = {
      name = "snacks.picker",
      note_mappings = {
        new = "<C-x>", -- создать заметку из запроса
        insert_link = "<C-l>", -- вставить ссылку на выбранную заметку
      },
      tag_mappings = {
        tag_note = "<C-x>", -- добавить тег к текущей заметке
        insert_tag = "<C-l>", -- вставить тег
      },
    },

    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      substitutions = {},
    },

    daily_notes = {
      folder = "notes/daily-notes",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      default_tags = { "daily-notes" },
      template = "DailyNote.md",
      workdays_only = false,
    },

    -- callbacks вместо старой таблицы mappings. <CR> (smart_action), ]o/[o и др. — дефолтные
    callbacks = {
      enter_note = function()
        vim.keymap.set("n", "ch", "<cmd>Obsidian toggle_checkbox<cr>", { buffer = true, desc = "Toggle checkbox" })
      end,
    },

    note_id_func = function(title)
      return title and title:lower():gsub("[%s—–-]+", "-") or tostring(os.time())
    end,

    link = {
      style = "wiki",
    },

    frontmatter = {
      func = function(note)
        if note.title then
          note:add_alias(note.title)
        end
        local out = {
          id = note.id,
          aliases = note.aliases,
          tags = note.tags or { "default-tag" }, -- Add a default tag
        }
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,
    },

    search = {
      sort_by = "modified",
      sort_reversed = true,
      max_lines = 1000,
    },

    open_notes_in = "current",

    -- UI плагина: в будущем уберут в пользу render-markdown (<leader>rm)
    ui = {
      enable = true,
      update_debounce = 200,
      max_file_length = 5000,
      checkboxes = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        ["!"] = { char = "", hl_group = "ObsidianImportant" },
      },
      bullets = { char = "•", hl_group = "ObsidianBullet" },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      reference_text = { hl_group = "ObsidianRefText" },
      highlight_text = { hl_group = "ObsidianHighlightText" },
      tags = { hl_group = "ObsidianTag" },
      block_ids = { hl_group = "ObsidianBlockID" },
      hl_groups = {
        ObsidianTodo = { bold = true, fg = "#f78c6c" },
        ObsidianDone = { bold = true, fg = "#89ddff" },
        ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
        ObsidianTilde = { bold = true, fg = "#ff5370" },
        ObsidianImportant = { bold = true, fg = "#d73128" },
        ObsidianBullet = { bold = true, fg = "#89ddff" },
        ObsidianRefText = { underline = true, fg = "#c792ea" },
        ObsidianExtLinkIcon = { fg = "#c792ea" },
        ObsidianTag = { italic = true, fg = "#89ddff" },
        ObsidianBlockID = { italic = true, fg = "#89ddff" },
        ObsidianHighlightText = { bg = "#75662e" },
      },
    },

    attachments = {
      folder = "assets/imgs",
      img_name_func = function()
        return string.format("%s-", os.time())
      end,
      img_text_func = function(path)
        local p = require("obsidian.path").new(path)
        local rel = p:vault_relative_path() or tostring(p)
        return string.format("![%s](%s)", p.name, rel)
      end,
    },
  },
}
