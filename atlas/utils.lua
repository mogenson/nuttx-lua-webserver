-- Begrudgingly, the junk drawer of functions in Atlas
--
-- This is for functions that I can't think of a better home for.
-- I don't like the existence of this module.
--
-- This module is NOT a public interface for Atlas apps.
local utils = {}

-- Returns a new table with parameters stored into an array, with field "n" being the total number of parameters
function utils.pack(...)
    local t = { ... }
    t.n = #t
    return t
end

-- Check if a value is in the table.
--
-- value: The value to scan for
--     t: The table to check against (assumes a list-like structure)
function utils.in_table(value, t)
    for _, t_value in ipairs(t) do if value == t_value then return true end end
    return false
end

--- split a string into a list of strings separated by a delimiter.
-- @param s The input string
-- @param re optional A Lua string pattern; defaults to '%s+'
-- @param plain optional If truthy don't use Lua patterns
-- @param n optional maximum number of elements (if there are more, the last will remian un-split)
-- @return a list-like table
-- @raise error if s is not a string
-- @see splitv
function utils.split(s, re, plain, n)
    local i1, ls = 1, {}
    if not re then re = '%s+' end
    if re == '' then return { s } end
    while true do
        local i2, i3 = string.find(s, re, i1, plain)
        if not i2 then
            local last = string.sub(s, i1)
            if last ~= '' then table.insert(ls, last) end
            if #ls == 1 and ls[1] == '' then
                return {}
            else
                return ls
            end
        end
        table.insert(ls, string.sub(s, i1, i2 - 1))
        if n and #ls == n then
            ls[#ls] = string.sub(s, i1)
            return ls
        end
        i1 = i3 + 1
    end
end

--- split a string into a number of return values.
-- Identical to `split` but returns multiple sub-strings instead of
-- a single list of sub-strings.
-- @param s the string
-- @param re A Lua string pattern; defaults to '%s+'
-- @param plain don't use Lua patterns
-- @param n optional maximum number of splits
-- @return n values
-- @usage first,next = splitv('user=jane=doe','=', false, 2)
-- assert(first == "user")
-- assert(next == "jane=doe")
-- @see split
function utils.splitv(s, re, plain, n)
    return (unpack or table.unpack)(utils.split(s, re, plain, n))
end

return utils
