require 'deepl.util'

local C = {
    defaults = {
        api_token = "",
        target_lang = "EN-US",
        model_type = "quality_optimized",
        formality = "default",
    },
    endpoints = {
        free = "https://api-free.deepl.com",
        pro = "https://api.deepl.com",
    },
    model_types = {
        "quality_optimized",
        "prefer_quality_optimized",
        "latency_optimized",
    },
    formality_levels = {
        "default",
        "more",
        "less",
        "prefer_more",
        "prefer_less",
    },
    settings = {},
}

local buffer_local = { "model_type", "formality", "target_lang" }

function C.setup(opts)
    opts = opts or {}
    local settings = {}

    table.merge(settings, C.defaults)
    table.merge(settings, opts)

    for setting, value in pairs(settings) do
        if table.contains(buffer_local, setting) then
            vim.g["deepl_" .. setting] = value
            settings[setting] = nil
        end
    end

    table.merge(C.settings, settings)
end

setmetatable(C, {
    __index = {
        get = function(self, setting)
            if table.contains(buffer_local, setting) then
                setting = "deepl_" .. setting
                return vim.b[setting] or vim.g[setting]
            end

            return self.settings[setting]
        end,
        set = function(self, setting, value)
            if table.contains(buffer_local, setting) then
                setting = "deepl_" .. setting
                vim.b[setting] = value
                return
            end

            self.settings[setting] = value
        end,
        endpoint = function(self, token)
            if string.ends_with(token, ':fx') then
                return self.endpoints.free
            end

            return self.endpoints.pro
        end,
    },
})

return C
