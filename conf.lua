package.path = package.path .. ";./modules/?.lua;./modules/?/init.lua;./modules/?/?.lua;"
package.path = package.path .. ";./src/?.lua;./src/?/?.lua"

function love.conf(e)
	e.console = true
end