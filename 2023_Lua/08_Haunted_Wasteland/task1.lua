local utils = require("utils")
local task = utils.load_task("input.txt")

if not task then
	return
end

local start = "AAA"
local goal = "ZZZ"
local current = start
local stepIndex = 1
local iterations = 0
local max_iterations = 1000000 -- 1 million

while current ~= goal do
	if iterations >= max_iterations then
		print("MAX ITERATIONS EXCEEDED: " .. tostring(max_iterations))
		break
	end

	local LR = string.sub(task.moves, stepIndex, stepIndex)
	current = task.map[current][LR]
	-- print("progress:", LR, stepIndex, "->", current)
	iterations = iterations + 1
	if current == goal then
		print("Reached " .. goal .. " in " .. tostring(iterations) .. " iterations!")
		break
	end

	-- move along
	stepIndex = stepIndex % string.len(task.moves) + 1
end
