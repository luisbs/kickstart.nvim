-- Adds gitsigns to the gutter and enable actions over git hunks (changes)
-- see https://github.com/lewis6991/gitsigns.nvim
-- see `:help gitsigns.txt`
--

return {
	'lewis6991/gitsigns.nvim',
	dependencies = {},
	config = function()
		require('gitsigns').setup {
			-- [[ behavior ]]
			max_file_length              = 40000, -- Disable if longer (in lines)
			auto_attach                  = true,
			attach_to_untracked          = true,
			--
			-- [[ visual cues ]]
			numhl                        = true, -- :Gitsigns toggle_numhl
			linehl                       = false, -- :Gitsigns toggle_linehl
			word_diff                    = false, -- :Gitsigns toggle_word_diff
			signcolumn                   = true, -- :Gitsigns toggle_signs
			signs                        = {
				add          = { text = '+' },
				change       = { text = '~' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = '~' },
				untracked    = { text = '┆' },
			},
			-- signs_staged        = {},
			-- signs_staged_enable = false,

			-- [[ visual metadata ]]
			current_line_blame           = true, -- :Gitsigns toggle_current_line_blame
			current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
			current_line_blame_opts      = { delay = 500, virt_text_pos = 'right_align', },

			-- [[ actions ]]
			on_attach                    = function(buffer)
				local gitsigns = require('gitsigns')
				local map = require('custom.nvim').group_map('Gitsigns: ', { buffer = buffer })

				-- navigation
				map('n', ']c', 'Go to next [c]hange', function()
					if vim.wo.diff then
						vim.cmd.normal({ ']c', bang = true })
					else
						gitsigns.nav_hunk('next')
					end
				end)

				map('n', '[c', 'Go to previous [c]hange', function()
					if vim.wo.diff then
						vim.cmd.normal({ '[c', bang = true })
					else
						gitsigns.nav_hunk('prev')
					end
				end)

				-- options toggles
				map('n', '<leader>tgn', '[t]oggle [n]umbers Highlight', '<CMD>Gitsigns toggle_numhl<CR>')
				map('n', '<leader>tgl', '[t]oggle [l]ines Highlight', '<CMD>Gitsigns toggle_linehl<CR>')
				map('n', '<leader>tgw', '[t]oggle [w]ords Highlight', '<CMD>Gitsigns toggle_word_diff<CR>')
				map('n', '<leader>tgs', '[t]oggle [s]igns on Gutter', '<CMD>Gitsigns toggle_signs<CR>')
				map('n', '<leader>tb', '[t]oggle Line [b]lame', gitsigns.toggle_current_line_blame)
				map('n', '<leader>td', '[t]oggle [d]eleted', gitsigns.toggle_deleted)

				-- actions
				local line = vim.fn.line
				map('v', '<leader>hr', 'Reset Hunk', function() gitsigns.reset_hunk { line('.'), line('v') } end)
				map('n', '<leader>hr', 'Reset Hunk', gitsigns.reset_hunk)
				map('n', '<leader>hR', 'Reset Buffer', gitsigns.reset_buffer)

				map('v', '<leader>hs', 'Stage Hunk', function() gitsigns.stage_hunk { line('.'), line('v') } end)
				map('n', '<leader>hs', 'Stage Hunk', gitsigns.stage_hunk)
				map('n', '<leader>hS', 'Stage Buffer', gitsigns.stage_buffer)

				map('n', '<leader>hu', 'Unstage Hunk', gitsigns.undo_stage_hunk)
				map('n', '<leader>hp', 'Preview Hunk', gitsigns.preview_hunk)
				map('n', '<leader>hb', 'Show Line Blame', function() gitsigns.blame_line { full = true } end)
				map('n', '<leader>hd', 'Diffsplit Buffer', gitsigns.diffthis)
				map('n', '<leader>hD', 'Diffsplit', function() gitsigns.diffthis('~') end)
			end
		}
	end
}
