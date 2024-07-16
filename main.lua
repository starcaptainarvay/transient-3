package.path = package.path .. ";./workflower/?.lua"

local flower = require('workflower')

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

function love.load()
    local threesum = flower({
        'adder1',
        {'adder1', 'adder2', 'adder3'},
        adder1 = adder,
        adder2 = adder,
        adder3 = adder
    })

    local storage, cell = flower.bucket('pipeToPrint')

    local recursiveAdd = flower({
        'recursiveAdder',
        {'recursiveAdder', {'recursiveAdder', 'recursiveAdderStorage'}, {'pipeToPrint'}, {'recursiveAdder', 'done'}},
        recursiveAdder = recursiveAdder,
        pipeToPrint = flower.pipe('recursiveAdder', function(...) print("Printing...", ...) end),
        recursiveAdderStorage = cell,
        done = recursiveDone
    })

    print(threesum(5, 2, 1))
    print(recursiveAdd(1, 1))
    print(storage:get())

    print(recursiveAdd)
end