package.path = package.path .. ";./workflower/?.lua"

local flower = require('workflower')
local workflower = require("workflower")
local b, f = flower.bucket('next')

local function adder(a, b, i)
    return nil, a + b, b, i + 1
end

local function recursiveAdder(a, b)
    print(string.format('adding %d to %d', b, a))
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


local function divideByZero(a, b, i)
    -- return nil, a, b, i
    return nil, g / 0, i
end

local threesum = flower({
    'adder1',
    {'adder1', 'adder2', 'divZero', 'adder3'},
    adder1 = adder,
    adder2 = adder,
    divZero = workflower.debug(divideByZero),
    adder3 = adder,
    error = function(e, results)
        print("BEEP BEEP BEEP!!! THREESUM ERRIOR!!!", e)
        print("results", unpack(results))
    end
})

local storage, cell = flower.bucket('pipeToPrint')
storage:get()

local recursiveAdd = flower({
    'recursiveAdder',
    {'recursiveAdder', {'recursiveAdder', 'recursiveAdderStorage'}, {'pipeToPrint'}, {'recursiveAdder', 'done'}},
    recursiveAdder = recursiveAdder,
    pipeToPrint = flower.pipe('recursiveAdder', function(...) print("Printing...", ...) end),
    recursiveAdderStorage = cell,
    done = recursiveDone,
    error = function(err, ...)
        print("BEEP BEEP BEEP!!! ERROR OCCURERED IN RECURSIVEADD!!!!", err, ...)
    end
})

print(threesum(5, 2, 1))
-- print(recursiveAdd(1, 1))
-- print(storage:get())

-- print(recursiveAdd)