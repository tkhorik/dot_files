-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- telescope
vim.keymap.set("n", "<leader>fs", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fp", ":Telescope git_files<cr>")
vim.keymap.set("n", "<leader>fz", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<cr>")
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<cr>")

-- tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")
-- vim.keymap.set("n", "<leader>t", vim.cmd.NERDTreeToggle)

-- icon picker
vim.keymap.set("n", "<leader>ic", ":IconPickerNormal<cr>", { noremap = true, silent = true })

-- twilight
vim.keymap.set("n", "<leader>il", ":Twilight<cr>")

-- zen mode
vim.keymap.set("n", "<leader>zm", ":ZenMode<cr>")

-- format code using LSP
-- vim.keymap.set("n", "<leader>pp", vim.lsp.buf.format)

-- markdown preview
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<cr>")

-- nvim-comment
vim.keymap.set({ "n", "v" }, "<leader>/", ":CommentToggle<cr>")

------------------
-- goto-preview --
------------------
--
-- note: lsp config (from lsp.lua)
-- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
-- nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
-- nmap('gt', vim.lsp.buf.type_definition, 'Type [D]efinition')
-- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--
vim.keymap.set("n", "<leader>gd", ":lua require('goto-preview').goto_preview_definition()<CR>")
vim.keymap.set("n", "<leader>gt", ":lua require('goto-preview').goto_preview_type_definition()<CR>")
vim.keymap.set("n", "<leader>gi", ":lua require('goto-preview').goto_preview_implementation()<CR>")
vim.keymap.set("n", "<leader>gp", ":lua require('goto-preview').close_all_win()<CR>")

-- Obsidian.nvim keymaps
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianToday<CR>", { desc = "Open Today’s Note" })
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "New Obsidian Note" })
vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open Obsidian App" })

-- Template picker (custom)
vim.keymap.set("n", "<leader>otm", function()
  local templates = { "daily.md", "meeting.md", "journal.md" }
  vim.ui.select(templates, { prompt = "Select a template:" }, function(choice)
    if choice then
      vim.cmd("ObsidianTemplate " .. choice)
    end
  end)
end, { desc = "Insert Template into Obsidian Note" })
vim.keymap.set("i", "<CR>", "<CR>")

-- Key mappings
vim.keymap.set("n", "<leader>ok", function()
  local filepath = vim.fn.expand("%:p") -- Get full path of current buffer
  local dest_dir = "/Users/marv/Documents/ObsidianVault/zettelkasten"
  local dest_path = dest_dir .. "/" .. vim.fn.expand("%:t") -- Append filename to destination directory

  -- Check if file exists
  if vim.fn.filereadable(filepath) == 0 then
    print("Error: File does not exist!")
    return
  end

  -- Check if destination directory exists
  if vim.fn.isdirectory(dest_dir) == 0 then
    print("Error: Destination directory does not exist!")
    return
  end

  -- Move file and handle errors
  local result = os.execute("mv " .. vim.fn.shellescape(filepath) .. " " .. vim.fn.shellescape(dest_dir))
  if result ~= 0 then
    print("Error: Failed to move file!")
    return
  end

  -- Close buffer after successful move
  vim.cmd("bd")
  print("File moved successfully to " .. dest_dir)
end)

vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>")
