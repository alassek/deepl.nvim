require 'deepl.util'

local C = {
    defaults = {
        api_endpoint = "https://api.deepl.com",
        api_token = "",
        target_lang = "EN-US",
        model_type = "quality_optimized",
        formality = "default",
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
    },
})

return C
