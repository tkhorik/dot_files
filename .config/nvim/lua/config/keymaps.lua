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

-- some keys for tabs switch
-- nnoremap gT :bp<CR>

vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "New Obsidian Note" })
-- vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianToday<CR>", { desc = "Open Today’s Note" })
-- vim.keymap.set("n", "<leader>on", "<cmd>ObsidianTemplate<CR>", { desc = "New Obsidian Note from Template" })
vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open Obsidian App" })
vim.keymap.set("n", "<leader>ot", function()
  local templates = { "daily.md", "meeting.md", "journal.md" } -- Add your templates here

  vim.ui.select(templates, { prompt = "Select a template:" }, function(choice)
    if choice then
      vim.cmd("ObsidianTemplate " .. choice)
    end
  end)
end, { desc = "Insert Template into Obsidian Note" })
