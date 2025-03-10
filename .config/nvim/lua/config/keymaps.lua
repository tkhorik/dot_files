-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- -- telescope
vim.keymap.set("n", "<leader>fs", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fp", ":Telescope git_files<cr>")
vim.keymap.set("n", "<leader>fz", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<cr>")
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<cr>")

-- tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- icon picker
vim.keymap.set("n", "<leader>ic", ":IconPickerNormal<cr>", { noremap = true, silent = true })

-- markdown preview
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<cr>")

vim.keymap.set("n", "<leader>gd", ":lua require('goto-preview').goto_preview_definition()<CR>")
vim.keymap.set("n", "<leader>gt", ":lua require('goto-preview').goto_preview_type_definition()<CR>")
vim.keymap.set("n", "<leader>gi", ":lua require('goto-preview').goto_preview_implementation()<CR>")
vim.keymap.set("n", "<leader>gp", ":lua require('goto-preview').close_all_win()<CR>")
