-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- -- Assuming you're setting up mappings in Lua
vim.api.nvim_set_keymap("n", "<leader>cp", ":CopilotChat<CR>", { noremap = true, silent = true })
