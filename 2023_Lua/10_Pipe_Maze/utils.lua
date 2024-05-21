M = {}

local utils_09 = require("utils_09") -- symlinked

M.lines_iterator = utils_09.lines_iterator


-- iterator for all 4 directions. Returns two values - dx, dy
function M.all_directions()
    do
        local data = {
            { dx = 1,  dy = 0 },
            { dx = -1, dy = 0 },
            { dx = 0,  dy = 1 },
            { dx = 0,  dy = -1 }
        }
        local index = 0
        return function()
            index = index + 1
            if not data[index] then
                index = 0 -- reset the iterator
                return nil, nil
            end
            return data[index].dx, data[index].dy
        end
    end
end

M.north_pipes = { -- have a connection at the top
    ["|"] = true,
    ["L"] = true,
    ["J"] = true,
}
M.south_pipes = { -- have a connection at the bottom
    ["|"] = true,
    ["7"] = true,
    ["F"] = true,
}
M.east_pipes = { -- have a connection on the RIGHT
    ["-"] = true,
    ["L"] = true,
    ["F"] = true,
}
M.west_pipes = { -- have a connection on the LEFT
    ["-"] = true,
    ["J"] = true,
    ["7"] = true,
}

return M
