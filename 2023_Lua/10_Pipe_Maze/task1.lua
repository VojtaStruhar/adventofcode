local filename = arg[1] or "input.txt"
local utils = require("utils")

local pipes = {}
local start_x = 0
local start_y = 0

local function coord(x, y)
    return x .. "x" .. y
end


local y = 0
for line in utils.lines_iterator(filename) do
    local x = 0
    for character in string.gmatch(line, ".") do
        local tile = {}
        if character == "S" then
            print("-- Start found at ", coord(x, y))
            start_x = x
            start_y = y
            tile.start = true
            tile.north = true -- the start connects to anything!
            tile.south = true -- the start connects to anything!
            tile.east = true  -- the start connects to anything!
            tile.west = true  -- the start connects to anything!
        else
            tile.north = utils.north_pipes[character]
            tile.south = utils.south_pipes[character]
            tile.east = utils.east_pipes[character]
            tile.west = utils.west_pipes[character]
        end
        tile.char = character -- debug reasons
        pipes[coord(x, y)] = tile
        x = x + 1
    end
    y = y + 1
end

-- Start at the 'S' position and go around the loop until you reach 'S' again
-- Count steps along the way. Half is the result.

local cur_x = start_x
local cur_y = start_y
local cur_tile = pipes[coord(cur_x, cur_y)]
local previous_tile = pipes[coord(cur_x, cur_y)]
local steps = 0

assert(cur_tile.start)

repeat
    for dx, dy in utils.all_directions() do
        local next_tile_coords = coord(cur_x + dx, cur_y + dy)
        local next_tile = pipes[next_tile_coords]
        if next_tile == previous_tile then
            -- no going back!!!
            goto next_direction
        end

        local has_connection = false
        if dx == 1 then      -- east neighbor
            has_connection = cur_tile.east and next_tile.west
        elseif dx == -1 then -- west neighbor
            has_connection = cur_tile.west and next_tile.east
        elseif dy == 1 then  -- south neighbor
            has_connection = cur_tile.south and next_tile.north
        elseif dy == -1 then -- north neighbor
            has_connection = cur_tile.north and next_tile.south
        end

        if has_connection then
            previous_tile = cur_tile
            cur_tile = next_tile
            cur_x = cur_x + dx
            cur_y = cur_y + dy
            goto new_tile
        end
        ::next_direction::
    end
    ::new_tile::
    steps = steps + 1
until cur_tile.start

print("-- Finished in " .. steps .. " steps!")
print("Result: " .. math.floor(steps / 2))
