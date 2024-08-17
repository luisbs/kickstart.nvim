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

---Generate a callback to add mapppings, grouped with a prefix
---@param group_desc string
---@param noremap boolean
---@param silent boolean
---@return function
M.group_map = function(group_desc, noremap, silent)
	---Add a mapping
	---@param modes string|string[]
	---@param keymap string
	---@param desc string
	---@param func any
	return function(modes, keymap, desc, func)
		vim.keymap.set(modes, keymap, func, { noremap = noremap, silent = silent, desc = group_desc .. desc })
	end
end

---Generate a callback to add mappings on normal mode, grouped with a prefix
---@param group_desc any
---@param noremap boolean
---@param silent boolean
---@return function
M.group_nmap = function(group_desc, noremap, silent)
	---Add a mapping to normal mode
	---@param keymap string
	---@param desc string
	---@param func any
	return function(keymap, desc, func)
		vim.keymap.set('n', keymap, func, { noremap = noremap, silent = silent, desc = group_desc .. desc })
	end
end

return M
