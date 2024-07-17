package.path = package.path .. ";./workflower/?.lua"

local flower = require('workflower')
local workflower = require("workflower")
local b, f = flower.bucket('next')

local function adder(a, b, i)
    return nil, a + b, b, i + 1
end

local function recursiveAdder(a, b)
    -- print(string.format('adding %d to %d', b, a))
    local _next = 'recursiveAdder'
    if a % 4 == 0 then
        _next = 'recursiveAdderStorage'
    elseif a % 7 == 0 then
        _next = 'done'
    end
    return _next, a + b, b
end

local function recursiveDone(a, b)
    return nil, a
end


local threesum = flower({
    'adder1',
    {'adder1', 'adder2', 'divZero', 'adder3'},
    adder1 = adder,
    adder2 = adder,
    adder3 = adder,
    error = function(e, results)
        print("BEEP BEEP BEEP!!! THREESUM ERRIOR!!!", e)
        print("results", unpack(results))
    end
})

local storage, cell = flower.queue('recursivebucket')
local storage2, cell2 = flower.bucket('recursiveAdder')

local recursiveAdd = flower({
    'recursiveAdder',
    {'recursiveAdder', {'recursiveAdder', 'recursiveAdderStorage'}, {'recursiveAdder', 'done'}},
    recursiveAdder = recursiveAdder,
    recursiveAdderStorage = cell,
    recursivebucket = cell2,
    done = recursiveDone,
    error = function(err, ...)
        print("BEEP BEEP BEEP!!! ERROR OCCURERED IN RECURSIVEADD!!!!", err, ...)
    end
})

storage:on("value", function(...)
    print("size:", storage:size(), "tail:", ...)
end)

-- print(threesum(5, 2, 1))
-- print(recursiveAdd(1, 1))

print(recursiveAdd)

for i=1, 3 do
    recursiveAdd(i, i)
end

print(storage)
print(storage2)