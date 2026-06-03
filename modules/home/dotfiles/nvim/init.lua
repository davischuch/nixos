-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = { "git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.nvim", mini_path }
	vim.fn.system(clone_cmd)
	vim.cmd("packadd mini.nvim | helptags ALL")
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Safely execute immediately
-- Vim Options
now(function()
	vim.g.mapleader = " "
	vim.opt.relativenumber = true
	vim.opt.tabstop = 2
	vim.opt.shiftwidth = 2
	vim.opt.expandtab = true
	vim.bo.softtabstop = 2
	vim.opt.scrolloff = 10
	vim.opt.splitbelow = true
	vim.opt.splitright = true
	vim.o.clipboard = "unnamedplus"
end)
-- Keymaps
now(function()
	local keymap = vim.keymap
	local opts = { noremap = true, silent = true }

	-- Tabs
	keymap.set("n", "te", ":tabedit")
	keymap.set("n", "<tab>", ":tabnext<Return>")
	keymap.set("n", "<s-tab>", ":tabprev<Return>")
	keymap.set("n", "tw", ":tabclose<Return>")

	-- Split window
	keymap.set("n", "ss", ":split<Return>")
	keymap.set("n", "sv", ":vsplit<Return>")
end)
now(function()
	require("mini.base16").setup({
		palette = {
			base00 = "#1d2021",
			base01 = "#3c3836",
			base02 = "#504945",
			base03 = "#665c54",
			base04 = "#bdae93",
			base05 = "#d5c4a1",
			base06 = "#ebdbb2",
			base07 = "#fbf1c7",
			base08 = "#fb4934",
			base09 = "#fe8019",
			base0A = "#fabd2f",
			base0B = "#b8bb26",
			base0C = "#8ec07c",
			base0D = "#83a598",
			base0E = "#d3869b",
			base0F = "#d65d0e",
		},
	})
end)
now(function()
	require("mini.icons").setup()
end)
now(function()
	require("mini.tabline").setup()
end)
now(function()
	require("mini.statusline").setup()
end)
now(function()
	require("mini.starter").setup()
end)
now(function()
	require("mini.bracketed").setup()
end)
now(function()
	require("mini.completion").setup()
end)
now(function()
	require("mini.files").setup()
end)
now(function()
	require("mini.basics").setup()
end)

-- Safely execute later
later(function()
	require("mini.ai").setup()
end)
later(function()
	require("mini.comment").setup()
end)
later(function()
	require("mini.operators").setup()
end)
later(function()
	require("mini.surround").setup()
end)
later(function()
	require("mini.pairs").setup()
end)
later(function()
	local hipatterns = require("mini.hipatterns")
	hipatterns.setup({
		highlighters = {
			-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
			fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
			hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
			todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
			note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

			-- Highlight hex color strings (`#rrggbb`) using that color
			hex_color = hipatterns.gen_highlighter.hex_color(),
		},
	})
end)

later(function()
	add({
		source = "folke/noice.nvim",
		depends = { "MunifTanjim/nui.nvim" },
	})
	require("noice").setup({
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = false, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
	})
end)

now(function()
	-- Use other plugins with `add()`. It ensures plugin is available in current
	-- session (installs if absent)
	add({
		source = "neovim/nvim-lspconfig",
		-- Supply dependencies near target plugin
		depends = { "folke/lazydev.nvim" },
	})
	-- Config so lua_ls can find vim global
	require("lazydev").setup({
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	})
	-- The Lsp's are being installed with nixpkgs
	require("lspconfig").nixd.setup({
		cmd = { "nixd" },
		settings = {
			nixd = {
				nixpkgs = {
					expr = "import <nixpkgs> { }",
				},
				formatting = {
					command = { "nixfmt" },
				},
				options = {
					nixos = {
						expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.laptop.options',
					},
				},
			},
		},
	})
	require("lspconfig").lua_ls.setup({})
	require("lspconfig").ts_ls.setup({})
	require("lspconfig").ccls.setup({})
end)

now(function()
	add({
		source = "stevearc/conform.nvim",
	})
	require("conform").setup({
		-- The formatters are being installed with nixpkgs
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	})
end)

now(function()
	add({
		source = "nvim-telescope/telescope.nvim",
		depends = { "nvim-lua/plenary.nvim" },
	})
	vim.keymap.set("n", "<space>fh", require("telescope.builtin").help_tags)
	vim.keymap.set("n", "<space>ff", require("telescope.builtin").find_files)
end)

later(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
		-- Use 'master' while monitoring updates in 'main'
		checkout = "master",
		monitor = "main",
		-- Perform action after every checkout
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})
	-- Possible to immediately execute code which depends on the added plugin
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"javascript",
			"typescript",
			"html",
			"css",
			"scss",
			"markdown",
			"markdown_inline",
			"bash",
			"regex",
		},

		-- Automatically install missing parsers when entering buffer
		auto_install = true,

		highlight = { enable = true },
	})
end)
