-- Customizes file-tree explorers.
-- see: https://github.com/nvim-neo-tree/neo-tree.nvim
-- `:Neotree filesystem reveal`		-- highlights current file
-- `:Neotree filesystem reveal right`	-- float|top|left|right
--

return {
	'nvim-neo-tree/neo-tree.nvim',
	branch = 'v3.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
		'MunifTanjim/nui.nvim',
		-- '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		require('custom.nvim').nmap("<A-e>", "LB: Show Filetree", "<CMD>Neotree show toggle reveal<CR>")
		require('neo-tree').setup {
			add_blank_line_at_top = false, -- Add a blank line at the top of the tree.
			close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
			open_files_in_last_window = true, -- false = open files in top left window
			-- git_status_async = true,

			-- enable_diagnostics = true,
			-- enable_git_status = true,
			-- enable_modified_markers = true, -- Show markers for files with unsaved changes.
			-- enable_opened_markers = true, -- Enable tracking of opened files. Required for `components.name.highlight_opened_files`
			-- enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
			enable_cursor_hijack = false, -- If enabled neotree will keep the cursor on the first letter of the filename when moving in the tree.

			-- popup_border_style is for input and confirmation dialogs.
			-- Configurtaion of floating window is done in the individual source sections.
			-- "NC" is a special style that works well with NormalNC set
			popup_border_style = "NC", -- "double", "none", "rounded", "shadow", "single" or "solid"
			sort_case_insensitive = true, -- used when sorting files and directories in the tree
			use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
			use_default_mappings = true,
			-- source_selector provides clickable tabs to switch between sources.
			source_selector = {
				winbar = true, -- toggle to show selector on winbar
				sources = { { source = "filesystem" }, { source = "git_status" }, { source = "buffers" } },
				content_layout = "center", -- horizontal_alignment: start, end, center
				tabs_layout = "equal", -- start, end, center, equal, active
				separator = { left = "", right = "" },
				-- separator = "|",
			},
			event_handlers = {
				-- 	{ event = "before_render", handler = function (state) end },
				-- 	{ event = "file_opened", handler = function(file_path) end },
				-- 	{ event = "file_opened", handler = function(file_path) require("neo-tree.sources.filesystem").reset_search() end },
				-- 	{ event = "file_renamed", handler = function(args) print(args.source, " renamed to ", args.destination) end },
				-- 	{ event = "file_moved", handler = function(args) print(args.source, " moved to ", args.destination) end },
				-- 	{ event = "neo_tree_buffer_enter", handler = function() end },
				-- 	{ event = "neo_tree_buffer_leave", handler = function() end },
				-- 	{ event = "neo_tree_window_before_open", handler = function(args) end },
				-- 	{ event = "neo_tree_window_after_open", handler = function(args) end },
				-- 	{ event = "neo_tree_window_before_close", handler = function(args) end },
				-- 	{ event = "neo_tree_window_after_close", handler = function(args) end },
			},
			default_component_configs = {
				name = {
					trailing_slash = true,
					highlight_opened_files = true,
					use_git_status_colors = true,
				},
				modified = { symbol = "󰜄 ", },
				git_status = {
					symbols = {
						-- Change type
						added     = "✚",
						deleted   = "✖",
						modified  = "",
						renamed   = "󰁕",
						-- Status type
						ignored   = "",
						untracked = "󱋭",
						unstaged  = "󰄱",
						staged    = "󰄲", -- 󰄲 󰄵
						conflict  = "",
					},
					align = "right",
				},
				file_size = { enabled = true, required_width = 64, },
				last_modified = { enabled = true, required_width = 88, },
				type = { enabled = true, required_width = 110, },
				created = { enabled = true, required_width = 120, },
				symlink_target = { enabled = true, required_width = 150 },
			},
			commands = {
				system_open = function(state)
					-- Linux only
					local path = state.tree:get_node():get_id()
					vim.fn.jobstart({ "xdg-open", path }, { detach = true })
				end,
			},
			window = {
				-- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
				-- possible options. These can also be functions that return these options.
				position = "left", -- left, right, top, bottom, float, current
				width = 40, -- applies to left and right positions
				height = 15, -- applies to top and bottom positions
				same_level = false, -- Create and paste/move files/directories on the same level as the directory under cursor (as opposed to within the directory under cursor).
				insert_as = "child", -- Affects how nodes get inserted into the tree during creation/pasting/moving of files if the node under the cursor is a directory:
				mapping_options = { noremap = true, nowait = true, },
				mappings = {
					-- ["<space>"] = { "toggle_node", nowait = true },
					["?"] = "show_help",
					-- ["q"] = "close_window",
					["<esc>"] = "cancel",
					["R"] = "refresh",
					["<"] = "prev_source",
					[">"] = "next_source",
					["e"] = "toggle_auto_expand_width",
					-- ["<cr>"] = { "open", config = { expand_nested_files = true } }, -- expand nested file takes precedence
					["<cr>"] = "open",
					["<2-LeftMouse>"] = "open",
					["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
					["<C-Up>"] = { "scroll_preview", config = { direction = -10 } },
					["<C-Down>"] = { "scroll_preview", config = { direction = 10 } },
					-- ["l"] = "focus_preview",
					-- ["w"] = "open_with_window_picker",
					-- ["S"] = "split_with_window_picker", requires dependency
					-- ["s"] = "vsplit_with_window_picker", requires dependency
					["S"] = "open_split",
					["s"] = "open_vsplit",
					-- ["sr"] = "open_rightbelow_vs", doesn't work
					-- ["sl"] = "open_leftabove_vs", doesn't work
					-- ["<cr>"] = "open_drop",
					-- ["t"] = "open_tabnew",
					-- ["t"] = "open_tab_drop",
					-- ["C"] = "close_node",
					["z"] = "close_all_nodes",
					["Z"] = "expand_all_nodes",
					["a"] = { "add", config = { show_path = "relative" } }, -- "none", "relative", "absolute"
					["A"] = { "add_directory", config = { show_path = "relative" } }, -- also accepts config.insert_as
					["d"] = { "delete", config = { show_path = "relative" } },
					["r"] = { "rename", config = { show_path = "relative" } },
					["c"] = { "copy", config = { show_path = "relative" } }, -- takes text input for destination, also accepts the config.show_path and config.insert_as options
					["m"] = { "move", config = { show_path = "relative" } }, -- takes text input for destination, also accepts the config.show_path and config.insert_as options
					-- ["y"] = "copy_to_clipboard",
					-- ["x"] = "cut_to_clipboard",
					-- ["p"] = "paste_from_clipboard",
				},
			},
			filesystem = {
				hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens within the window like netrw would.
				use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes instead of relying on nvim autocmd events.
				search_limit = 50, -- max number of search results when using filters
				find_by_full_path_words = true,
				filtered_items = {
					visible = true, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false, -- only works on Windows for hidden files/directories
					-- hide_by_name = { ".DS_Store", "thumbs.db" }, --"node_modules",
					-- hide_by_pattern = { "*.meta", "*/src/*/tsconfig.json" }, -- uses glob style patterns
					always_show = { ".gitignored", }, -- remains visible even if other settings would normally hide it
					never_show = { ".DS_Store", "thumbs.db" }, -- remains hidden even if visible is toggled to true, this overrides always_show
					-- never_show_by_pattern = { ".null-ls_*", }, -- uses glob style patterns
				},
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
				components = {
					harpoon_index = function(config, node, _)
						local cwd = vim.uv.cwd()
						local path = node:get_id()
						local list = require('harpoon'):list()

						for i, item in ipairs(list.items) do
							local value = item.value
							if string.sub(item.value, 1, 1) ~= "/" then
								value = cwd .. "/" .. item.value
							end

							if value == path then
								vim.print(path)
								return {
									text = string.format(" ⇀%d", i),
									highlight = config.highlight or
									    "NeoTreeDirectoryIcon",
								}
							end
						end
						return {}
					end
				},
				renderers = {
					file = {
						{ "indent" },
						{ "icon" },
						{
							"container",
							content = {
								{ "name",           zindex = 10 },
								{ "symlink_target", zindex = 10 },
								{ "clipboard",      zindex = 10 },
								{ "bufnr",          zindex = 10 },
								{ "harpoon_index",  zindex = 10, align = "right" },
								{ "modified",       zindex = 20, align = "right" },
								{ "diagnostics",    zindex = 20, align = "right" },
								{ "git_status",     zindex = 10, align = "right" },
								{ "file_size",      zindex = 10, align = "right" },
								{ "type",           zindex = 10, align = "right" },
								{ "last_modified",  zindex = 10, align = "right" },
								{ "created",        zindex = 10, align = "right" },
							},
						},
					},
				},
				window = {
					mappings = {
						["so"] = "system_open",
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						["D"] = "fuzzy_finder_directory",
						--["/"] = "filter_as_you_type", -- this was the default until v1.28
						["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
						-- ["D"] = "fuzzy_sorter_directory",
						["f"] = "filter_on_submit",
						["<C-x>"] = "clear_filter",
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
						["i"] = "show_file_details",
						["o"] = { "show_help", nowait = false, config = {
							title = "Order by",
							prefix_key = "o"
						} },
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["og"] = { "order_by_git_status", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
				},
			},
			buffers = {},
			git_status = {},
			document_symbols = { follow_cursor = true, },
		}
	end,
}
