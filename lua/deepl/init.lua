local M = {}
local config = require('deepl.config')
local api = require('deepl.api')
local ui = require('deepl.ui')

function M.translate(opts)
    local source_lang = opts.args ~= "" and opts.args:upper() or nil

    -- Get the visual selection
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)

    local selected_text = nil

    -- Handle line selection
    if #lines == 1 then
        selected_text = lines[1]:sub(start_pos[3], end_pos[3])
    else
        lines[1] = lines[1]:sub(start_pos[3])
        lines[#lines] = lines[#lines]:sub(1, end_pos[3])
        selected_text = table.concat(lines, "\n")
    end

    local translation = api.translate(selected_text, source_lang)
    if translation then
        -- Replace the selection with the translation
        vim.api.nvim_buf_set_text(
            0,  -- current buffer
            start_pos[2] - 1,  -- start row (0-indexed)
            start_pos[3] - 1,  -- start col (0-indexed)
            end_pos[2] - 1,    -- end row (0-indexed)
            end_pos[3],        -- end col (0-indexed)
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
