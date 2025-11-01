local M = {}
local config = require('deepl.config')
local api = require('deepl.api')
local ui = require('deepl.ui')

local function selection()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local end_line = vim.api.nvim_buf_get_lines(0, end_pos[2] - 1, end_pos[2], false)[1]

    sel = {
        start_row = start_pos[2] - 1,
        start_col = start_pos[3] - 1,
        end_row = end_pos[2] - 1,
        end_col = math.min(end_pos[3], #end_line + 1),
    }

    local lines = vim.api.nvim_buf_get_lines(0, sel.start_row, sel.end_row + 1, false)
    sel.end_col = math.min(sel.end_col, #lines[#lines])
    sel.lines = lines

    return sel
end

function M.translate(opts)
    local source_lang = opts.args ~= "" and opts.args:upper() or nil

    local sel = selection()
    local selected_text = ""

    -- Handle line selection
    if #sel.lines == 1 then
        selected_text = sel.lines[1]:sub(sel.start_col + 1, sel.end_col)
    else
        sel.lines[1] = sel.lines[1]:sub(sel.start_col + 1)
        sel.lines[#sel.lines] = sel.lines[#sel.lines]:sub(1, sel.end_col)
        selected_text = table.concat(sel.lines, "\n")
    end

    local translation = api.translate(selected_text, source_lang)
    if translation then
        -- Replace the selection with the translation
        vim.api.nvim_buf_set_text(
            0,  -- current buffer
            sel.start_row,
            sel.start_col,
            sel.end_row,
            sel.end_col,
            vim.split(translation, '\n')  -- replacement text as lines
        )
    end
end

function M.setup(opts)
    config.setup(opts)

    vim.api.nvim_create_user_command('Translate', M.translate, {
        range = true,
        nargs = '?',
        desc = 'Translate selected text using DeepL API',
    })

    vim.api.nvim_create_user_command('DeepL', function(opts) ui.Menu(opts.args) end, {
        nargs = '?',
        desc = 'Configure DeepL settings',
    })
end

return M
