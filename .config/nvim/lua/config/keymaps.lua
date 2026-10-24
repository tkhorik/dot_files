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
-- vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")
-- vim.keymap.set("n", "<leader>t", vim.cmd.NERDTreeToggle)

-- format code using LSP
-- vim.keymap.set("n", "<leader>pp", vim.lsp.buf.format)

-- markdown preview
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<cr>", { desc = "Markdown Preview Toggle" })

-- Obsidian.nvim keymaps
vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian today<CR>", { desc = "Open Today’s Note" })
vim.keymap.set("n", "<leader>on", "<cmd>Obsidian new<CR>", { desc = "New Obsidian Note" })
vim.keymap.set("n", "<leader>oo", "<cmd>Obsidian open<CR>", { desc = "Open Obsidian App" })

-- Template picker: без аргумента :Obsidian template показывает все шаблоны из vault/templates
vim.keymap.set("n", "<leader>oT", "<cmd>Obsidian template<CR>", { desc = "Insert Template into Obsidian Note" })

-- Key mappings
vim.keymap.set("n", "<leader>ok", function()
  local filepath = vim.fn.expand("%:p")
  local dest_dir = "/Users/marv/Documents/ObsidianVault/zettelkasten"
  local dest_path = dest_dir .. "/" .. vim.fn.expand("%:t")

  local saved, save_error = pcall(vim.cmd, "write")
  if not saved then
    vim.notify("Failed to save note: " .. save_error, vim.log.levels.ERROR)
    return
  end

  if vim.fn.filereadable(filepath) == 0 then
    vim.notify("Cannot stage note because the current file does not exist", vim.log.levels.ERROR)
    return
  end

  if vim.fn.mkdir(dest_dir, "p") == -1 then
    vim.notify("Failed to create staging directory: " .. dest_dir, vim.log.levels.ERROR)
    return
  end

  if vim.uv.fs_stat(dest_path) then
    vim.notify("A staged note already exists at " .. dest_path, vim.log.levels.ERROR)
    return
  end

  local moved, move_error = vim.uv.fs_rename(filepath, dest_path)
  if not moved then
    vim.notify("Failed to stage note: " .. (move_error or "unknown error"), vim.log.levels.ERROR)
    return
  end

  vim.api.nvim_buf_delete(0, {})
  vim.notify("Note staged at " .. dest_path, vim.log.levels.INFO)
end, { desc = "Stage Obsidian note for sorting" })

vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>")
