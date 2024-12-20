local filename = arg[1] or "input.txt"
local utils = require("utils")
local last = utils.last

local total = 0

for line in utils.lines_iterator(filename) do
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
end


print("Result:", total)
