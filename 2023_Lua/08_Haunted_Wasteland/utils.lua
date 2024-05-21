M = {}

function M.load_task(filename)
	local f = io.open(filename)
	if f == nil then
		print("FAILED TO OPEN FILE: " .. filename)
		return
	end
	print("Reading `" .. filename .. "`")

	local result = {
		map = {},
		moves = f:read("l"),
	}

	local _ = f:read("l") -- skip one line

	local line = f:read("l")
	while line ~= nil do
		local node = string.sub(line, 1, 3)

		result.map[node] = {
			L = string.sub(line, 8, 10),
			R = string.sub(line, 13, 15),
		}

		line = f:read("l") -- advance
	end

	return result
end

return M
