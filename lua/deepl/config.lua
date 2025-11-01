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

local function merge(tbl1, tbl2)
    for k, v in pairs(tbl2) do
        tbl1[k] = v
    end
    return tbl1
end

function C.setup(opts)
    opts = opts or {}
    merge(C.settings, C.defaults)
    merge(C.settings, opts)
end

function C.set(key, value)
    merge(C.settings, {[key] = value})
end

return C
