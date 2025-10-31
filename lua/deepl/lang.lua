local L = {
    source = {
        ["AR"] = "Arabic",
        ["BG"] = "Bulgarian",
        ["CS"] = "Czech",
        ["DA"] = "Danish",
        ["DE"] = "German",
        ["EL"] = "Greek",
        ["EN"] = "English",
        ["ES"] = "Spanish",
        ["ET"] = "Estonian",
        ["FI"] = "Finnish",
        ["FR"] = "French",
        ["HE"] = "Hebrew",
        ["HU"] = "Hungarian",
        ["ID"] = "Indonesian",
        ["IT"] = "Italian",
        ["JA"] = "Japanese",
        ["KO"] = "Korean",
        ["LT"] = "Lithuanian",
        ["LV"] = "Latvian",
        ["NB"] = "Norwegian Bokmål",
        ["NL"] = "Dutch",
        ["PL"] = "Polish",
        ["PT"] = "Portuguese",
        ["RO"] = "Romanian",
        ["RU"] = "Russian",
        ["SK"] = "Slovak",
        ["SL"] = "Slovenian",
        ["SV"] = "Swedish",
        ["TH"] = "Thai",
        ["TR"] = "Turkish",
        ["UK"] = "Ukrainian",
        ["VI"] = "Vietnamese",
        ["ZH"] = "Chinese",
    },
    target = {
        ["AR"] = "Arabic",
        ["BG"] = "Bulgarian",
        ["CS"] = "Czech",
        ["DA"] = "Danish",
        ["DE"] = "German",
        ["EL"] = "Greek",
        ["EN"] = "English (Unspecified)",
        ["EN-GB"] = "English (British)",
        ["EN-US"] = "English (American)",
        ["ES"] = "Spanish",
        ["ES-419"] = "Spanish (Latin American)",
        ["ET"] = "Estonian",
        ["FI"] = "Finnish",
        ["FR"] = "French",
        ["HE"] = "Hebrew",
        ["HU"] = "Hungarian",
        ["ID"] = "Indonesian",
        ["IT"] = "Italian",
        ["JA"] = "Japanese",
        ["KO"] = "Korean",
        ["LT"] = "Lithuanian",
        ["LV"] = "Latvian",
        ["NB"] = "Norwegian Bokmål",
        ["NL"] = "Dutch",
        ["PL"] = "Polish",
        ["PT"] = "Portuguese (Unspecified)",
        ["PT-BR"] = "Portuguese (Brazilian)",
        ["PT-PT"] = "Portuguese (Portugal)",
        ["RO"] = "Romanian",
        ["RU"] = "Russian",
        ["SK"] = "Slovak",
        ["SL"] = "Slovenian",
        ["SV"] = "Swedish",
        ["TH"] = "Thai",
        ["TR"] = "Turkish",
        ["UK"] = "Ukrainian",
        ["VI"] = "Vietnamese",
        ["ZH"] = "Chinese (Unspecified)",
        ["ZH-HANS"] = "Chinese (Simplified)",
        ["ZH-HANT"] = "Chinese (Traditional)",
    },
}

setmetatable(L, {
    __index = {
        resolve = function(self, kind)
            return assert(self[kind], "must be one of: 'source', 'target'. got: " .. kind)
        end,
        options = function(self, kind)
            local langs = self:resolve(kind)
            local opts = {}

            for code, _ in pairs(langs) do
                table.insert(opts, code)
            end

            table.sort(opts)

            return opts
        end,
        format_option = function(self, kind)
            local langs = self:resolve(kind)

            return function(item)
                return string.format("%s : %s", item, langs[item])
            end
        end,
    }
})

return L
