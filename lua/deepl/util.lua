function string.camelize(str)
    return str:gsub("^(%l)", string.upper):gsub("_(%l)", function(letter)
        return letter:upper()
    end)
end

function string.titleize(str)
    return str:gsub("(%a)([%w_']*)", function(first, rest)
        return first:upper() .. rest:lower()
    end):gsub("_", " ")
end

function string.ends_with(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end

function table.merge(left, right)
    for k, v in pairs(right) do
        left[k] = v
    end
    return left
end

function table.contains(tbl, val)
    for _, v in ipairs(tbl) do
        if v == val then
            return true
        end
    end
    return false
end
