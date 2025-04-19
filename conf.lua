package.path = package.path .. ";./modules/?.lua;./modules/?/init.lua;./modules/?/?.lua" 	-- workflower, transient ECS library
package.path = package.path .. ";./src/?.lua;./src/?/?.lua"									-- transient implementation
package.path = package.path .. ";./src/systems/?/init.lua;./src/systems/?/?.lua"			-- transient systems

function love.conf(e)
	e.console = true
end