--[[
    I read this thing, partly

    https://www.lua.org/pil/contents.html
--]]


function mark(title)
    print("\n  --== MARK: " .. title .. " ==--\n")
end

function fact(n)
    if n == 0 then
        return 1
    else
        return n * fact(n - 1)
    end
end

print("enter a number:")
local a
-- a = io.read("*number") -- read a number
if tonumber(a) == nil then
    print("not a number")
else
    print("Factorial: ", fact(a))
end

-- MARK: - Chunks
mark("Chunks")

a = 1
local b = a * 2

print(a, b)

a = 1;
b = a * 2;

a = 1;
b = a * 2

-- formatter ruins this :)
-- a = 1  b = a * 2 -- ugly, but valid

-- MARK: Functions?
mark("Functions")
-- you can import them into scope with `dofile`. I'm not sure what's the difference from `require` yet.

function norm(x, y)
    local n2 = x ^ 2 + y ^ 2
    return math.sqrt(n2)
end

function twice(x)
    return 2 * x
end

print(nonexistent)  -- this is a nonexistent global variable. Contains `nil` by default

local variable = 69 -- not visible when I do `dofile` :)

vojta = "Vojta is of type"
print(vojta, type("vojta"))

if "" and 0 and {} then
    print("Empty string, zero and empty table are all truthy values!")
end

if nil or false then
    print("nil and false are the only falsy values - this will never get printed")
end

-- MARK: Strings
mark("Strings")

local lua_stones = "lua stones"
print(string.gsub(lua_stones, "stones", "rocks")) -- strings are immutable, new string is always created

print("one line\nnext line\n\"in quotes\", 'in quotes'")
print('a backslash inside quotes: \'\\\'')
print("a simpler way: '\\'")

-- converted to strings automatically
print(4 .. 20)

-- MARK: Tables
mark("Tables")

t = { elon = "musk" } -- the key doesn't have "" around it!
local key = "les"
local val = "gou"
t[key] = val
print(t[key])                 -- gou
print(t.key or "not here :)") -- nil
print(t.les)                  -- gou

print("-- dictionary iteration")
-- iterate like a dictionary with `pairs`?
for key, val in pairs(t) do
    print(key, val)
end


arr = { "This", "table", "is indexed", "by numbers?" }
-- iterate like an array with `ipairs`
print("-- array iteration")
for i, line in ipairs(arr) do
    print(i, line)
end
print("^ notice it indexes from 1 :D")

print("-- table initialization craziness")
t = {
    could_be_variable = "val",
    ["string_literal_key"] = "val",
    "array-like element here",
    { "internal_array?" }, -- internal array, but really it's a table
    { table = true }       -- internal table
}
for key, value in pairs(t) do
    print(key, value)
end

mark("Assignment")


a, b = 42, 128 -- each variable gets its own, as you would expect
print(a, b)
a, b = b, a    -- swap values works too :)
print(a, b)


mark("Matrix experiment")

matrix = {}
matrix.elements = { 1, 2, 3, 4, 5, 6, 7, 8, 9 }
matrix.row = function(index)
    local row = {}
    for i = 1, 3, 1 do
        row[i] = matrix.elements[(index - 1) * 3 + i]
    end
    return row
end
matrix.print = function()
    for i = 1, 3, 1 do
        print(table.unpack(matrix.row(i)))
    end
end
matrix.get = function(row, col)
    return matrix.elements[(row - 1) * 3 + col]
end
matrix.print()

print(matrix.get(2, 1)) -- 4

matrix.a = function() return matrix.get(1, 1) end
matrix.b = function() return matrix.get(1, 2) end
matrix.c = function() return matrix.get(1, 3) end
matrix.e = function() return matrix.get(2, 1) end
matrix.d = function() return matrix.get(2, 2) end
matrix.f = function() return matrix.get(2, 3) end
matrix.g = function() return matrix.get(3, 1) end
matrix.h = function() return matrix.get(3, 2) end
matrix.i = function() return matrix.get(3, 3) end

print(matrix.a(), matrix.b(), matrix.c())           -- i was hoping I could omit the parentheses

matrix.a = function(self) return self.get(1, 1) end -- self isn't a special or reserved keyword. It's just a convention for the first parameter (like python!)
matrix.b = function(self) return self.get(1, 2) end
matrix.c = function(self) return self.get(1, 3) end

print(matrix:a(), matrix:b(), matrix:c()) -- The colon assigns the object itself as the first argument

mark "Functions"                          -- SEE WHAT I DID THERE?! Parentheses optional :)
print "This prints"

-- doesn't work, I guess just the first thing is bound?
-- print "This prints" "Multiple things" "Without parentheses"


print [[
    Multiline!
    Stuff printed however I want. This could be pretty good
    for defining dialogues in lua files I think.
]]

function multiprint(text)
    print(text)
    return multiprint
end

-- Okay interesting. Multiprint returns itself from the interaction with "One",
-- so the other strings can be chained like this. That's pretty cool.
multiprint "One" "Two" "Three"


function varargs(...)
    local printResult = ""
    print(table.unpack(arg))
    for i, v in ipairs(arg) do
        printResult = printResult .. tostring(v) .. " "
    end

    print("varargs", printResult)
end

varargs("This", "is", "a", "varargs", "function", "in", "lua")

mark "Closures"

names = { "Peter", "Paul", "Mary" }
grades = {
    Mary = 1,
    Peter = 4,
    Paul = 2
}

function sortbygrade(names, grades)
    print("-- Sorting by grades...")
    table.sort(names, function(n1, n2)
        return grades[n1] < grades[n2] -- compare the grades
    end)
end

for i, name in ipairs(names) do
    print(name)
end
sortbygrade(names, grades)
for i, name in ipairs(names) do
    print(name)
end

mark "Files"

function serialize(o)
    if type(o) == "number" then
        io.write(o)
    elseif type(o) == "string" then
        io.write(string.format("%q", o)) -- the %q is a safe escaped format option
    else
        print("Unknown data type: " .. type(o))
    end
end

f = io.open("testfile.txt", "w")
io.output(f)
serialize("Hello, world!")
serialize(69)
io.close(f)

print("-- Try JSON")
local json = require("json")

local testfile = io.open("testfile.json", "w")
if testfile then
    testfile:write(json.encode({
        key = "value",
        inner_table = {
            some_key = "some_value",
            can_be_number = true
        },
        number = 12,
        array = { "let's", "get", "down", "to", "business" }
    }))
    testfile:close()
end
