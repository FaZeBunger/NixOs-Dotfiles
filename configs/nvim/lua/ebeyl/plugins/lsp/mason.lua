return {
	"williamboman/mason.nvim",
	dependencies = {
        {
		    "williamboman/mason-lspconfig.nvim",
            version = '^1.0'
        },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
    version = '^1.0',
	config = function()
		local mason = require("mason")

		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		---@diagnostic disable-next-line: missing-fields
		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"rust_analyzer",
				"marksman",
				"lua_ls",
				"clangd",
				"pyright",
                "nixd",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"isort",
				"black",
				"pylint",
			},
		})
	end,
}
