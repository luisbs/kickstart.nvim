--- Utility functions around Vim/NeoVim
---

local M = {}

---Add a mapping
---@param modes string|string[]
---@param keymap string
---@param desc string
---@param func any
M.map = function(modes, keymap, desc, func)
	-- noremap by default
	vim.keymap.set(modes, keymap, func, { noremap = true, silent = true, desc = desc })
end

---Add a mapping to normal mode
---@param keymap string
---@param desc string
---@param func any
M.nmap = function(keymap, desc, func)
	vim.keymap.set('n', keymap, func, { noremap = true, silent = true, desc = desc })
end

---Add a mapping to visual mode
---@param keymap string
---@param desc string
---@param func any
M.vmap = function(keymap, desc, func)
	vim.keymap.set('v', keymap, func, { noremap = true, silent = true, desc = desc })
end

---Generate a callback to add mapppings, grouped with a prefix
---@param group_desc string
---@param opts table
---@return function
M.group_map = function(group_desc, opts)
	opts = opts or {}
	---Add a mapping
	---@param modes string|string[]
	---@param keymap string
	---@param desc string
	---@param func any
	return function(modes, keymap, desc, func)
		vim.keymap.set(modes, keymap, func, vim.tbl_deep_extend('keep', opts, { desc = group_desc .. desc }))
	end
end

---Generate a callback to add mappings on normal mode, grouped with a prefix
---@param group_desc any
---@param opts table
---@return function
M.group_nmap = function(group_desc, opts)
	opts = opts or {}
	---Add a mapping to normal mode
	---@param keymap string
	---@param desc string
	---@param func any
	return function(keymap, desc, func)
		vim.keymap.set('n', keymap, func, vim.tbl_deep_extend('keep', opts, { desc = group_desc .. desc }))
	end
end

---Generate a callback to add mappings on visual mode, grouped with a prefix
---@param group_desc any
---@param opts table
---@return function
M.group_vmap = function(group_desc, opts)
	opts = opts or {}
	---Add a mapping to normal mode
	---@param keymap string
	---@param desc string
	---@param func any
	return function(keymap, desc, func)
		vim.keymap.set('v', keymap, func, vim.tbl_deep_extend('keep', opts, { desc = group_desc .. desc }))
	end
end

return M
