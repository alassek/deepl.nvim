local M = {}

local curl = require('plenary.curl')
local config = require('deepl.config').settings

local diag_ns = vim.api.nvim_create_namespace("deepl")
local user_agent = "neovim/" .. tostring(vim.version()) .. " (deepl.nvim)"

local function http_error(status, message)
    vim.diagnostic.open_float(0, {
        namespace = diag_ns,
        scope = "cursor",
        header = "DeepL API Error: " .. tostring(status),
        source = "http",
        format = function()
            return message
        end,
    })
end

function M.translate(text, source_lang)
    if config.api_token == "" then
        http_error(0, "DeepL API token is not set.")
        return
    end

    local url = config.api_endpoint .. "/v2/translate"
    local body = {
        text = {text},
        source_lang = source_lang,
        target_lang = config.target_lang,
        model_type = config.model_type,
        formality = config.formality,
    }
    local response = curl.post(url, {
        headers = {
            ["Authorization"] = "DeepL-Auth-Key " .. config.api_token,
            ["Content-Type"] = "application/json",
            ["User-Agent"] = user_agent,
        },
        body = vim.fn.json_encode(body),
    })

    if response.status ~= 200 then
        http_error(response.status, response.body)
        return
    end

    local result = vim.fn.json_decode(response.body)
    if result["translations"] then
        return result["translations"][1]["text"]
    end
end

return M
