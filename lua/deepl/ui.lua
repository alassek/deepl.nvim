local M = {}
local config = require('deepl.config')
local lang = require('deepl.lang')

require 'deepl.util'

function M.TargetLanguage()
    vim.ui.select(
        lang:options('target'),
        {
            prompt = "Target Language:",
            format_item = lang:format_option("target"),
        },
        function(choice)
            if choice then
                config:set('target_lang', choice)
            end
        end
    )
end

function M.Model()
    vim.ui.select(
        config.model_types,
        { prompt = "Select DeepL model type:" },
        function(choice)
            if choice then
                config:set('model_type', choice)
            end
        end
    )
end

function M.Formality()
    vim.ui.select(
        config.formality_levels,
        { prompt = "Select DeepL formality:" },
        function(choice)
            if choice then
                config:set('formality', choice)
            end
        end
    )
end

function M.Menu(option)
    option = string.camelize(option)

    if option == "" then
        vim.ui.select(
            {"model", "formality", "target_language"},
            {
                prompt = "Configure DeepL settings:",
                format_item = string.titleize,
            },
            function(choice)
                option = string.camelize(choice)
                M[option]()
            end
        )
    elseif M[option] then
        M[option]()
    end
end

return M
