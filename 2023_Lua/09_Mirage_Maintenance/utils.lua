M = {}


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

return M
