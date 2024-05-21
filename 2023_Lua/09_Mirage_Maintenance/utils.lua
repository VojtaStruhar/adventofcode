local M = {}


function M.is_all_zeroes(array)
    for _, value in ipairs(array) do
        if value ~= 0 then return false end
    end
    return true
end

function M.last(list)
    return list[#list]
end

-- for debugging. Prints array of arrays (history in this case)
function M.print2D(listoflists)
    for _, value in ipairs(listoflists) do
        print(table.unpack(value))
    end
end

function M.create_history(number_row)
    local history = { number_row }
    local current_row = number_row

    while not M.is_all_zeroes(current_row) do
        local diff_row = {}
        for i = 1, #current_row - 1, 1 do
            table.insert(diff_row, current_row[i + 1] - current_row[i])
        end
        table.insert(history, diff_row)
        current_row = diff_row
    end

    return history
end

function M.lines_iterator(filename)
    local f = io.open(filename)
    if f == nil then
        print("FAILED TO OPEN: " .. filename)
        return function()
            return nil
        end
    end

    print("Reading " .. filename)
    return function()
        return f:read("l")
    end
end

return M
