local filename = arg[1] or "input.txt"
local utils = require("utils")
local last = utils.last

local get_line = utils.lines_iterator(filename)
local line = get_line()
local total = 0


while line ~= nil do
    local current_row = {}
    for n in string.gmatch(line, "-?%d+") do
        table.insert(current_row, tonumber(n))
    end

    local history = utils.create_history(current_row)

    -- extrapolate
    table.insert(last(history), 0)
    for i = #history, 2, -1 do
        local extr_value = last(history[i - 1]) + last(history[i])
        table.insert(history[i - 1], extr_value)
    end

    -- update score
    total = total + last(history[1])
    -- move along
    line = get_line()
end


print("Result:", total)
