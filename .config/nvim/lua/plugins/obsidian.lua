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
      -- Add these to improve tag completion
      new_notes = true, -- Trigger completion in new notes
      prepend_note_id = true,
      use_path_only = false,
    },

    workspaces = {
      {
        name = "primary_vault",
        path = vim.fn.expand("~/Documents/ObsidianVault"),
        overrides = {
          notes_subdir = "inbox",
          new_notes_location = "notes_subdir", ---here was changed you can return it back tomorrow
          -- daily_notes = {
          --   folder = "dailies", -- Relative to vault root
          --   date_format = "%Y-%m-%d",
          --   template = "daily.md", -- REQUIRED field [4][6]
          -- },
          templates = {
            folder = "templates", -- Relative to vault root
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
          },
        },
      },
    },
    -- Optional, for templates (see below).
    templates = {
      folder = "templates",
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
      -- template = nil,
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

    -- preferred_link_style = "wiki",

    -- note_frontmatter_func = function(note)
    --   if note.title then
    --     note:add_alias(note.title)
    --   end
    --   local out = { id = note.id, aliases = note.aliases, tags = note.tags }
    --   if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
    --     for k, v in pairs(note.metadata) do
    --       out[k] = v
    --     end
    --   end
    --   return out
    -- end,

    note_frontmatter_func = function(note)
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
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url })
    end,

    follow_img_func = function(img)
      vim.fn.jobstart({ "qlmanage", "-p", img })
    end,

    open_app_foreground = true,
    -- picker = {
    --   name = "telescope.nvim",
    --   note_mappings = { new = "", insert_link = "" },
    --   tag_mappings = { tag_note = "", insert_tag = "" },
    -- },

    picker = {
      -- Установите предпочитаемый выборщик. Может быть одним из 'telescope.nvim', 'fzf-lua' или 'mini.pick'.
      name = "telescope.nvim",
      -- Необязательно, настроить сопоставления клавиш для выборщика. Это значения по умолчанию.
      -- Не все выборщики поддерживают все сопоставления.
      note_mappings = {
        -- Создать новую заметку из вашего запроса.
        new = "<C-x>",
        -- Вставить ссылку на выбранную заметку.
        insert_link = "<C-l>",
      },

      tag_mappings = {
        -- Добавить тег(и) к текущей заметке.
        tag_note = "<C-x>",
        -- Вставить тег в текущее место.
        insert_tag = "<C-l>",
      },
    },

    sort_by = "modified",
    sort_reversed = true,

    search_max_lines = 1000,

    open_notes_in = "current",

    ui = {
      enable = true, -- установите значение false, чтобы отключить все дополнительные функции синтаксиса
      update_debounce = 200, -- задержка обновления после изменения текста (в миллисекундах)
      max_file_length = 5000, -- отключить функции пользовательского интерфейса для файлов с количеством строк, превышающим это значение
      -- Определите, как отображаются различные флажки.
      checkboxes = {
        -- ПРИМЕЧАНИЕ: значение 'char' должно быть одним символом, а группы подсветки определены ниже.
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        ["!"] = { char = "", hl_group = "ObsidianImportant" },
        -- Замените приведенное выше на это, если у вас нет пропатченного шрифта:
        -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
        -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

        -- Вы также можете добавить больше пользовательских...
      },
      -- Использовать маркеры для списков без флажков.
      bullets = { char = "•", hl_group = "ObsidianBullet" },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      -- Замените приведенное выше на это, если у вас нет пропатченного шрифта:
      -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      reference_text = { hl_group = "ObsidianRefText" },
      highlight_text = { hl_group = "ObsidianHighlightText" },
      tags = { hl_group = "ObsidianTag" },
      block_ids = { hl_group = "ObsidianBlockID" },
      hl_groups = {
        -- Параметры передаются непосредственно в `vim.api.nvim_set_hl()`. См. `:help nvim_set_hl`.
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
