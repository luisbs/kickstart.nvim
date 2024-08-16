--- This file modifies the core UI hooks (select, input, etc)
--- see: https://github.com/stevearc/dressing.nvim
---

return {
	'stevearc/dressing.nvim',
	opts = {
		input = {
			enabled = true, -- Set to false to disable the vim.ui.input implementation
			default_prompt = "Input...", -- Default prompt string
			--title_pos = "left", -- Can be 'left', 'right', or 'center'
			--border = "rounded", -- These are passed to nvim_open_win
			--relative = "cursor", -- 'editor' and 'win' will default to being centered
			prefer_width = 40, -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			max_width = { 140, 0.9 }, -- means "the smaller of 140 columns or 90% of total"
			min_width = { 20, 0.2 }, -- means "the greater of 20 columns or 20% of total"
			mappings = {
				n = {
					["<Esc>"] = "Close",
					["<CR>"] = "Confirm",
				},
				i = {
					["<C-q>"] = "Close",
					["<CR>"] = "Confirm",
					["<Up>"] = "HistoryPrev",
					["<Down>"] = "HistoryNext",
				},
			},
		},
		select = {
			enabled = true, -- Set to false to disable the vim.ui.select implementation
			-- Priority list of preferred vim.select implementations
			-- backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
			backend = { "fzf_lua", "fzf", "builtin", "nui" },
			-- Options for telescope selector
			telescope = nil,
			-- Options for fzf selector
			fzf = {
				window = {
					width = 0.5,
					height = 0.4,
				},
			},
			-- Options for fzf-lua
			fzf_lua = {
				-- winopts = {
				--   height = 0.5,
				--   width = 0.5,
				-- },
			},
			-- Options for nui Menu
			nui = {
				position = "50%",
				size = nil,
				relative = "editor",
				border = {
					style = "rounded",
				},
				buf_options = {
					swapfile = false,
					filetype = "DressingSelect",
				},
				win_options = {
					winblend = 0,
				},
				max_width = 80,
				max_height = 40,
				min_width = 40,
				min_height = 10,
			},
			-- Options for built-in selector
			builtin = {
				-- Display numbers for options and set up keymaps
				show_numbers = true,
				-- These are passed to nvim_open_win
				border = "rounded",
				-- 'editor' and 'win' will default to being centered
				relative = "editor",
				buf_options = {},
				win_options = {
					cursorline = true,
					cursorlineopt = "both",
				},
				-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- the min_ and max_ options can be a list of mixed types.
				-- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
				width = nil,
				max_width = { 140, 0.8 },
				min_width = { 40, 0.2 },
				height = nil,
				max_height = 0.9,
				min_height = { 10, 0.2 },
				-- Set to `false` to disable
				mappings = {
					["<Esc>"] = "Close",
					["<C-q>"] = "Close",
					["<CR>"] = "Confirm",
				},
				override = function(conf)
					-- This is the config that will be passed to nvim_open_win.
					-- Change values here to customize the layout
					return conf
				end,
			},
		},
	},
}
