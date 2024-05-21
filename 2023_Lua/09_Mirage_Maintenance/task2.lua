local filename = arg[1] or "input.txt"
local utils = require("utils")

local total = 0

for line in utils.lines_iterator(filename) do
    local current_row = {}
    for n in string.gmatch(line, "-?%d+") do
        table.insert(current_row, tonumber(n))
    end

    local history = utils.create_history(current_row)

    -- kinda prepend 0
    table.insert(utils.last(history), 1, 0)

    -- extrapolate, going from top to (original) base
    for i = #history, 2, -1 do
        local extr_value = history[i - 1][1] - history[i][1]
        table.insert(history[i - 1], 1, extr_value)
    end

    -- update score
    total = total + history[1][1]
end

print("Result:", total)
