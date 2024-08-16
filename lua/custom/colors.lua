-- Custom colors used on the configuration files
--

local M = {}
-- setup = function()
-- end,

---@type table<string, string>
M.grayscale = {
	GrayscaleDark  = '#1F1F1F',
	GrayscaleLight = '#1A1A1A',
}

---@type table<string, string>
M.rainbow = {
	RainbowRed = '#E06C75',
	RainbowOrange = '#D19A66',
	-- RainbowYellow = '#E5C07B',
	RainbowGreen = '#98C379',
	RainbowCyan = '#56B6C2',
	RainbowBlue = '#61AFEF',
	RainbowViolet = '#C678DD',
}

---Set the passed colors as foreground & background
---@param prefix string
---@param colors Map<string, string>
M.setColorsTogether = function(prefix, colors)
	for name, color in pairs(colors) do
		vim.api.nvim_set_hl(0, prefix .. name, { fg = color, bg = color })
	end
end

---Set the passed colors as foreground
---@param prefix string
---@param colors Map<string, string>
M.setColorsForeground = function(prefix, colors)
	for name, color in pairs(colors) do
		vim.api.nvim_set_hl(0, prefix .. name, { fg = color })
	end
end

---Set the passed colors as background
---@param prefix string
---@param colors Map<string, string>
M.setColorsBackground = function(prefix, colors)
	for name, color in pairs(colors) do
		vim.api.nvim_set_hl(0, prefix .. name, { bg = color })
	end
end

return M
