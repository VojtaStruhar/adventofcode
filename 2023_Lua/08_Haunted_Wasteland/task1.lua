local f = io.open("input.txt")
if f == nil then
    print("FAILED TO OPEN FILE")
    return
end


local moves = f:read("l")
print("Moves sequence: " .. tostring(string.len(moves)))

local _ = f:read("l") -- skip one line

local map = {}

local line = f:read("l")
while line ~= nil
do
    local node = string.sub(line, 1, 3)

    map[node] = {
        L = string.sub(line, 8, 10),
        R = string.sub(line, 13, 15)
    }

    line = f:read("l") -- advance
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

    local LR = string.sub(moves, stepIndex, stepIndex)
    current = map[current][LR]
    -- print("progress:", LR, stepIndex, "->", current)
    iterations = iterations + 1
    if current == goal then
        print("Reached " .. goal .. " in " .. tostring(iterations) .. " iterations!")
        break
    end

    -- move along
    stepIndex = stepIndex % string.len(moves) + 1
end
