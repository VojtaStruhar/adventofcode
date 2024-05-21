--[[
    I wrote this in neovim btw. The lua there is okay-ish lol.
--]]

local utils = require("utils")
local task = utils.load_task("input.txt")

if not task then
	return
end

-- array of path lengths of starting nodes to SOME end node.
local path_lengths = {}

-- get the starting nodes, they have to end with 'A'
for key, _ in pairs(task.map) do
	if string.sub(key, 3, 3) == "A" then
		local steps = 0
		local node = key

		while string.sub(node, 3, 3) ~= "Z" do
			local stepIndex = steps % task.move_count + 1
			local move = string.sub(task.moves, stepIndex, stepIndex)
			node = task.map[node][move]
			steps = steps + 1
		end
		print("Found loop for " .. key .. " at " .. tostring(steps) .. " steps")

		table.insert(path_lengths, steps)
	end
end

local result = path_lengths[1]
for i = 2, #path_lengths, 1 do
	result = utils.lcm(result, path_lengths[i])
end

print("The least common multiple of all path lengths is", math.floor(result))
