vim.g.mapleader = " "

local keymap = vim.keymap

-- Splitting Windows
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Split Navigation
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Moves to the tab to the right" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Moves to the tab to the top" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Moves to the tab to the bottom" })
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Moves to the tab to the left" })

-- Tab Management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open a new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close tab
keymap.set("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Go to next tab" }) -- go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Go to previous tab" }) -- go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
