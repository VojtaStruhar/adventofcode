local filename = arg[1] or "input.txt"
local f = io.open(filename)
if f == nil then
    print("FAILED TO OPEN: " .. filename)
    return
end
print("Reading " .. filename)

local utils = require("utils")
local last = utils.last

local line = f:read("l")
local total = 0

while line ~= nil do
    local history = {}
    local current_row = {}
    for n in string.gmatch(line, "-?%d+") do
        table.insert(current_row, tonumber(n))
    end
    table.insert(history, current_row)

    while not utils.is_all_zeroes(current_row) do
        local diff_row = {}
        for i = 1, #current_row - 1, 1 do
            table.insert(diff_row, current_row[i + 1] - current_row[i])
        end
        table.insert(history, diff_row)
        current_row = diff_row
    end

    -- extrapolate
    table.insert(last(history), 0)
    for i = #history, 2, -1 do
        local extr_value = last(history[i - 1]) + last(history[i])
        table.insert(history[i - 1], extr_value)
    end

    -- update score
    total = total + last(history[1])
    -- move along
    line = f:read("l")
end


print("Result:", total)
