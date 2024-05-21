--[[
    I wrote this in neovim btw. The lua there is alright.
--]]

local task = require("utils").load_task("input.txt")

if not task then
	return
end

local current = {}

-- get the starting nodes, they have to end with 'A'
for key, _ in pairs(task.map) do
	if string.sub(key, 3, 3) == "A" then
		table.insert(current, key)
	end
end

-- debug
for _, value in ipairs(current) do
	print("Starting node:", value)
end

-- now iterate the `current` (starting) values until all of them end in `Z`

local stepIndex = 1
local max_iterations = 1000

for iteration = 0, max_iterations, 1 do
	-- check if we arrived at the goal

	local goalReached = true
	for index, value in ipairs(current) do
		if string.sub(value, 3, 3) ~= "Z" then
			goalReached = false
			print(value .. " break after " .. tostring(index))
		end
	end
	if goalReached then
		print("Goal reached after " .. tostring(iteration) .. " iterations!")
		return
	end

	-- advance the search
	local move = string.sub(task.moves, stepIndex, stepIndex)
	print(move)
	for index, value in ipairs(current) do
		current[index] = task.map[value][move]
	end

	stepIndex = stepIndex % string.len(task.moves) + 1
end

print("Max iterations exceeded ", max_iterations)
